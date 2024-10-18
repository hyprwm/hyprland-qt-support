import QtQuick
import QtQuick.Controls.Basic as T

T.Button {
  id: control

  background: Rectangle {
    implicitWidth: 50
    implicitHeight: 30
    color: control.down ? Qt.tint(control.palette.button, Qt.alpha(control.palette.highlight, 0.4)) : control.palette.button
    radius: 10
    border.color: control.hovered ? control.palette.highlight : control.palette.light
    border.width: 1
  }
}
