import "../GlobalSettings"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Rectangle {
    property string _TEXT: "Sample Text"
    property string _HINT: ""
    property var _FONT_SIZE: 11
    property var _TEXTBOX_SIZE: 150
    property var _HEIGHT: 30
    property string _CURRENT: "Hello"

    visible: true
    color: "#00000000"

    MouseArea {
        id: __textMouseArea

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
                ToolTip.visible: __textMouseArea.containsMouse && _HINT != ""
                ToolTip.text: _HINT
                ToolTip.delay: 400
                elide: Text.ElideRight
            }

            Rectangle {
                color: "#00000000"
                Layout.fillWidth: true
            }

            TextField {
                id: __textValueText

                text: _CURRENT
                Layout.preferredWidth: _TEXTBOX_SIZE
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                onPressed: () => {
                    _CURRENT = __textValueText.text;
                }
                onReleased: () => {
                    _CURRENT = __textValueText.text;
                }
            }

            Rectangle {
                color: "#00000000"
                Layout.preferredWidth: 6
            }

        }

    }

    SystemPalette {
        id: system

        colorGroup: SystemPalette.Active
    }

}
