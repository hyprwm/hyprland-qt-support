import "../GlobalSettings"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Rectangle {
    property string _TEXT: "Sample Checkbox"
    property string _HINT: ""
    property var _FONT_SIZE: 11
    property var _BUTTON_SIZE: 20
    property var _HEIGHT: 30
    property var _CHECKED: true

    visible: true
    color: "#00000000"

    MouseArea {
        id: __checkboxMouseArea

        height: _HEIGHT
        width: parent.width
        hoverEnabled: true

        RowLayout {
            spacing: 0
            anchors.fill: parent

            Rectangle {
                color: "#00000000"
                Layout.minimumWidth: 6
            }

            Text {
                font.pointSize: _FONT_SIZE
                text: _TEXT
                color: system.windowText
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                ToolTip.visible: __checkboxMouseArea.containsMouse && _HINT != ""
                ToolTip.text: _HINT
                ToolTip.delay: 400
            }

            Rectangle {
                color: "#00000000"
                Layout.fillWidth: true
            }

            CheckBox {
                checked: _CHECKED
                Layout.preferredWidth: _BUTTON_SIZE
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
            }

            Rectangle {
                color: "#00000000"
                Layout.minimumWidth: 6
            }

        }

    }

    SystemPalette {
        id: system

        colorGroup: SystemPalette.Active
    }

}
