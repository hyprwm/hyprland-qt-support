#include <qguiapplication.h>
#include <qlogging.h>
#include <qqmlengine.h>
#include <qqmlextensionplugin.h>
#include <qtmetamacros.h>
#include <qstylehints.h>
#include <qtpreprocessorsupport.h>

void qml_register_types_org_hyprland_style(); // NOLINT

class HyprlandQuickStylePlugin : public QQmlEngineExtensionPlugin {
    Q_OBJECT;
    Q_PLUGIN_METADATA(IID QQmlEngineExtensionInterface_iid);

  public:
    HyprlandQuickStylePlugin(QObject* parent = nullptr) : QQmlEngineExtensionPlugin(parent) {
        volatile auto registration = &qml_register_types_org_hyprland_style;
        Q_UNUSED(registration);
    }

    void initializeEngine(QQmlEngine* /*unused*/, const char* /*unused*/) override {
        // Works around a qt6ct bug that prevents controls from receiving hover state changes
        // https://github.com/trialuser02/qt6ct/blob/55dba8704c0a748b0ce9f2d3cc2cf200ca3db464/src/qt6ct-qtplugin/qt6ctplatformtheme.cpp#L307
        // Note the missing `HoverEffects`.
        QGuiApplication::styleHints()->setUseHoverEffects(true);
    }
};

#include "plugin.moc"
