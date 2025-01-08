#include "checkdelegate.hpp"
#include <qnamespace.h>
#include <qobject.h>
#include <qwindowdefs.h>
#include <qpainter.h>
#include <qpainterpath.h>

namespace hyprqml::style {
    CheckDelegate::CheckDelegate() {
        QObject::connect(this, &CheckDelegate::checkStateChanged, this, &CheckDelegate::repaint);
        QObject::connect(this, &CheckDelegate::colorChanged, this, &CheckDelegate::repaint);
    }

    void CheckDelegate::repaint() {
        this->update();
    }

    void CheckDelegate::paint(QPainter* painter) {
        auto size   = static_cast<int>(this->width()); // assume square and even
        auto middle = size / 2;

        switch (this->bCheckState) {
            case Qt::Unchecked: break;
            case Qt::PartiallyChecked:
                painter->setPen(Qt::NoPen);
                painter->setBrush(this->bColor.value());
                painter->setRenderHint(QPainter::Antialiasing, false);
                painter->drawRect(1, middle - 1, size - 2, 2);
                break;
            default:
                QPen pen = this->bColor.value();
                pen.setWidth(2);
                pen.setCapStyle(Qt::FlatCap);
                pen.setJoinStyle(Qt::MiterJoin);
                painter->setPen(pen);
                painter->setBrush(Qt::NoBrush);
                painter->setRenderHint(QPainter::Antialiasing, true);

                QPainterPath path;
                path.moveTo(size - 1, 2);
                path.lineTo(middle - 1, size - 2);
                path.lineTo(1, middle);
                painter->drawPath(path);
                break;
        }
    }
}
