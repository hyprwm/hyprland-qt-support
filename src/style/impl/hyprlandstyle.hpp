#pragma once

#include <qobject.h>
#include <qproperty.h>
#include <qqmlintegration.h>
#include <qtmetamacros.h>
#include <qfilesystemwatcher.h>

namespace hyprqml::style {
    class HyprlandStyleBase : public QObject {
        Q_OBJECT;
        QML_ELEMENT;
        // writes are mostly intended for tester
        Q_PROPERTY(int roundness READ default WRITE default BINDABLE bindableRoundness NOTIFY
                       roundnessChanged);
        Q_PROPERTY(int borderWidth READ default WRITE default BINDABLE bindableBorderWidth NOTIFY
                       borderWidthChanged);
        Q_PROPERTY(bool reduceMotion READ default WRITE default BINDABLE bindableReduceMotion NOTIFY
                       reduceMotionChanged);

      public:
        explicit HyprlandStyleBase();

        [[nodiscard]] QBindable<int> bindableRoundness() {
            return &this->bRoundness;
        }
        [[nodiscard]] QBindable<int> bindableBorderWidth() {
            return &this->bBorderWidth;
        }
        [[nodiscard]] QBindable<bool> bindableReduceMotion() {
            return &this->bReduceMotion;
        }

      signals:
        void roundnessChanged();
        void borderWidthChanged();
        void reduceMotionChanged();

      private slots:
        void fileChanged();
        void directoryChanged();

      private:
        void loadConfig();

        Q_OBJECT_BINDABLE_PROPERTY(HyprlandStyleBase, int, bRoundness,
                                   &HyprlandStyleBase::roundnessChanged);
        Q_OBJECT_BINDABLE_PROPERTY(HyprlandStyleBase, int, bBorderWidth,
                                   &HyprlandStyleBase::borderWidthChanged);
        Q_OBJECT_BINDABLE_PROPERTY(HyprlandStyleBase, bool, bReduceMotion,
                                   &HyprlandStyleBase::reduceMotionChanged);

        QString            configPath;
        QFileSystemWatcher configWatcher;
    };
}
