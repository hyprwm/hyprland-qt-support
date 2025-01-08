#pragma once

#include <qnamespace.h>
#include <qobject.h>
#include <qproperty.h>
#include <qqmlintegration.h>
#include <qtmetamacros.h>
#include <qquickpainteditem.h>
#include <qwindowdefs.h>

namespace hyprqml::style {
    class CheckDelegate : public QQuickPaintedItem {
        Q_OBJECT;
        QML_ELEMENT;
        Q_PROPERTY(Qt::CheckState checkState READ default WRITE default BINDABLE bindableCheckState
                       NOTIFY checkStateChanged);

        Q_PROPERTY(
            QColor color READ default WRITE default BINDABLE bindableColor NOTIFY colorChanged);

      public:
        explicit CheckDelegate();

        [[nodiscard]] QBindable<QColor> bindableColor() {
            return &this->bColor;
        }
        [[nodiscard]] QBindable<Qt::CheckState> bindableCheckState() {
            return &this->bCheckState;
        }

        void paint(QPainter* painter) override;

      signals:
        void colorChanged();
        void checkStateChanged();

      private slots:
        void repaint();

      private:
        Q_OBJECT_BINDABLE_PROPERTY(CheckDelegate, QColor, bColor, &CheckDelegate::colorChanged);
        Q_OBJECT_BINDABLE_PROPERTY(CheckDelegate, Qt::CheckState, bCheckState,
                                   &CheckDelegate::checkStateChanged);
    };
}
