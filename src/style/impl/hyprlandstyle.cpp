#include "hyprlandstyle.hpp"
#include <hyprlang.hpp>
#include <any>
#include <qfileinfo.h>
#include <qfilesystemwatcher.h>
#include <qlist.h>
#include <qdir.h>
#include <qobject.h>
#include <qtenvironmentvariables.h>
#include <qlogging.h>
#include <qloggingcategory.h>

namespace {
    Q_LOGGING_CATEGORY(logStyle, "hyprland.style", QtWarningMsg);
}

namespace hyprqml::style {
    HyprlandStyleBase::HyprlandStyleBase() {
        QObject::connect(&this->configWatcher, &QFileSystemWatcher::fileChanged, this,
                         &HyprlandStyleBase::fileChanged);
        QObject::connect(&this->configWatcher, &QFileSystemWatcher::directoryChanged, this,
                         &HyprlandStyleBase::directoryChanged);

        auto basePaths  = QList<QString>();
        auto home       = qEnvironmentVariable("XDG_CONFIG_HOME");
        auto configDirs = qEnvironmentVariable("XDG_CONFIG_DIRS");

        if (home.isEmpty())
            basePaths << qEnvironmentVariable("HOME") % "/.config";
        else
            basePaths << home;

        if (configDirs.isEmpty())
            basePaths << "/etc/xdg";
        else
            basePaths << configDirs.split(':');

        qCDebug(logStyle) << "Hyprland style configuration paths:" << basePaths;

        this->configPath = basePaths.first() % "/hypr/application-style.conf";
        for (const auto& basePath : basePaths) {
            auto path = basePath % "/hypr/application-style.conf";

            if (QFileInfo(path).isFile()) {
                this->configPath = path;
                break;
            }
        }

        this->configWatcher.addPath(this->configPath);
        this->configWatcher.addPath(QFileInfo(this->configPath).dir().path());
        this->loadConfig();
    }

    void HyprlandStyleBase::loadConfig() {
        qCDebug(logStyle) << "Reloading configuration from" << this->configPath;

        Hyprlang::INT roundness    = 1;
        Hyprlang::INT borderWidth  = 1;
        Hyprlang::INT reduceMotion = 0;

        try {
            auto config = Hyprlang::CConfig(this->configPath.toStdString().c_str(), {});

            config.addConfigValue("roundness", roundness);
            config.addConfigValue("border_width", borderWidth);
            config.addConfigValue("reduce_motion", reduceMotion);

            config.commence();
            config.parse();

            roundness    = std::any_cast<Hyprlang::INT>(config.getConfigValue("roundness"));
            borderWidth  = std::any_cast<Hyprlang::INT>(config.getConfigValue("border_width"));
            reduceMotion = std::any_cast<Hyprlang::INT>(config.getConfigValue("reduce_motion"));
        } catch (...) { return; }

        if (roundness < 0 || roundness > 3) {
            qCWarning(logStyle) << "Invalid value" << roundness
                                << "for roundness. Must be in range 0-3.";
            roundness = 1;
        }

        if (borderWidth < 0 || borderWidth > 3) {
            qCWarning(logStyle) << "Invalid value" << borderWidth
                                << "for border_width. Must be in range 0-3.";
            borderWidth = 1;
        }

        this->bRoundness    = static_cast<int>(roundness);
        this->bBorderWidth  = static_cast<int>(borderWidth);
        this->bReduceMotion = reduceMotion;
    }

    void HyprlandStyleBase::fileChanged() {
        if (!this->configWatcher.files().contains(this->configPath)) {
            this->configWatcher.addPath(this->configPath);
            return;
        }

        this->loadConfig();
    }

    void HyprlandStyleBase::directoryChanged() {
        if (!this->configWatcher.files().contains(this->configPath) &&
            QFileInfo(this->configPath).isFile()) {
            this->configWatcher.addPath(this->configPath);
            this->loadConfig();
        }

        // if the directory was deleted we stop watching
    }
}
