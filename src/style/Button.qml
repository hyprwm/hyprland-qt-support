import QtQuick
import QtQuick.Templates as T
import org.hyprland.style.impl

// This is private and we shouldn't use it, however rewriting IconLabel would take hundreds of
// lines of C++ to end up with something worse.
import QtQuick.Controls.impl as ControlsPrivate

T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    icon.width: 24
    icon.height: 24
    icon.color: control.palette.buttonText

    contentItem: ControlsPrivate.IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display

        icon: control.icon
        text: control.text
        font: control.font
        color: control.palette.buttonText
    }

    background: Rectangle {
        implicitWidth: 50
        implicitHeight: 30

        radius: HyprlandStyle.radius
        border.width: HyprlandStyle.borderWidth

        MotionBehavior on color { ColorAnimation { duration: 60 } }
        color: {
            let highlightTint = control.down || control.checked ? 0.3 : control.highlighted ? 0.25 : 0.0;

            if (control.flat && highlightTint)
                highlightTint += 0.3;

            const base = HyprlandStyle.flat(control.palette.button, control.flat);
            return HyprlandStyle.overlay(base, control.palette.highlight, highlightTint);
        }

        MotionBehavior on border.color { ColorAnimation { duration: 60 } }
        border.color: {
            let highlightTint = control.down || control.checked ? 0.8 : (control.enabled && control.hovered) || control.highlighted ? 0.6 : 0.0;

            if (control.flat && highlightTint)
                highlightTint += 0.2;

            const base = HyprlandStyle.flat(HyprlandStyle.lightenOrDarken(control.palette.button, 1.4), control.flat);
            return HyprlandStyle.overlay(base, control.palette.highlight, highlightTint);
        }
    }
}
