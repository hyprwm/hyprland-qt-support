import QtQuick
import QtQuick.Controls.Basic as T
import org.hyprland.style.impl

T.Button {
    id: control

    background: Rectangle {
        implicitWidth: 50
        implicitHeight: 30

        radius: HyprlandStyle.radius
        border.width: HyprlandStyle.borderWidth

        MotionBehavior on color { ColorAnimation { duration: 50 } }
        color: control.down || control.checked
               ? Qt.tint(control.palette.button, Qt.alpha(control.palette.highlight, 0.4))
               : control.flat ? "transparent" : control.palette.button

        MotionBehavior on border.color { ColorAnimation { duration: 50 } }
        border.color: control.hovered || control.highlighted || control.down || control.checked
                      ? control.palette.highlight
                      : control.flat ? "transparent" : control.palette.light
    }
}
