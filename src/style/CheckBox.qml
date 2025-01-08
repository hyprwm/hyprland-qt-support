import QtQuick
import QtQuick.Templates as T
import org.hyprland.style.impl

T.CheckBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0

        text: control.text
        font: control.font
        color: control.palette.windowText
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }

    indicator: Rectangle {
        implicitWidth: 16
        implicitHeight: 16

        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: Math.round(control.topPadding + (control.availableHeight - height) / 2)

        radius: {
            switch (HyprlandStyle.roundness) {
            case 0: return 0;
            case 1: return 4;
            case 2: return 6;
            case 3: return 8;
            }
        }

        border.width: HyprlandStyle.borderWidth

        MotionBehavior on color { ColorAnimation { duration: 60 } }
        color: {
            let highlightTint = control.checkState !== Qt.Unchecked ? 0.3 : control.highlighted ? 0.25 : 0.0;

            const base = Qt.darker(control.palette.button, control.down ? 1.1 : 1.0);
            return HyprlandStyle.overlay(base, control.palette.highlight, highlightTint);
        }

        MotionBehavior on border.color { ColorAnimation { duration: 60 } }
        border.color: {
            let highlightTint = control.down || control.checkState !== Qt.Unchecked ? 1.0 : (control.enabled && control.hovered) || control.highlighted ? 0.6 : 0.0;

            const base = HyprlandStyle.lightenOrDarken(control.palette.button, 1.4);
            return HyprlandStyle.overlay(base, control.palette.highlight, highlightTint);
        }

        CheckDelegate {
            anchors.fill: parent
            anchors.margins: 2
            checkState: control.checkState
            color: control.palette.buttonText
        }
    }
}
