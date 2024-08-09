import "../GlobalSettings"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Rectangle {
    property var _WIDTH: 200
    property var _HEIGHT: 30
    property var _MARGIN_HR: 20
    property var _THICKNESS: 1
    property var _FONT_SIZE: 11
    property var _TEXT: "Sample Category"

    visible: true
    color: "#00000000"
    radius: 8
    implicitWidth: _WIDTH
    implicitHeight: _HEIGHT

    ColumnLayout {
        spacing: 2
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Rectangle {
            // pad
            color: "#00000000"
            Layout.fillHeight: true
        }

        Text {
            font.pointSize: _FONT_SIZE
            text: _TEXT
            color: Qt.tint(system.mid, system.text)
            height: _FONT_SIZE
        }

        Rectangle {
            width: _WIDTH - 2 * _MARGIN_HR
            height: _THICKNESS

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 0
                    color: Qt.tint(system.mid, system.text)
                }

                GradientStop {
                    position: 1
                    color: Qt.alpha(Qt.tint(system.mid, system.text), 0.0)
                }

            }

        }

    }

    SystemPalette {
        id: system

        colorGroup: SystemPalette.Active
    }

}
