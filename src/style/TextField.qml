import QtQuick
import QtQuick.Templates as T
import org.hyprland.style.impl

import QtQuick.Controls.impl

T.TextField {
    id: control

    implicitWidth: implicitBackgroundWidth + leftInset + rightInset
                   || Math.max(contentWidth, placeholder.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    padding: 6

    color: control.palette.text
    selectionColor: control.palette.highlight
    selectedTextColor: control.palette.highlightedText
    placeholderTextColor: control.palette.placeholderText
    verticalAlignment: TextInput.AlignVCenter

    Text {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)

        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: control.renderType
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 30

        radius: {
            switch (HyprlandStyle.roundness) {
            case 0: return 0;
            case 1: return 4;
            case 2: return 8;
            case 3: return 16;
            }
        }

        border.width: HyprlandStyle.borderWidth

        color: control.palette.base

        MotionBehavior on border.color { ColorAnimation { duration: 60 } }
        border.color: {
            let highlightTint = control.activeFocus ? 1.0 : (control.enabled && control.hovered) || control.highlighted ? 0.6 : 0.0;

            const base = HyprlandStyle.lightenOrDarken(control.palette.button, 1.4);
            return HyprlandStyle.overlay(base, control.palette.highlight, highlightTint);
        }
    }
}
