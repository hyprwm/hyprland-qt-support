import "../GlobalSettings"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Rectangle {
    property string _TEXT: "Sample Combo"
    property string _HINT: ""
    property var _FONT_SIZE: 11
    property var _COMBO_SIZE: 150
    property var _HEIGHT: 30
    property var _CURRENT: 0
    property var _MODEL: ["Option 1", "Option 2", "Option 3"]

    visible: true
    color: "#00000000"

    MouseArea {
        id: __comboMouseArea

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
                ToolTip.visible: __comboMouseArea.containsMouse && _HINT != ""
                ToolTip.text: _HINT
                ToolTip.delay: 400
                elide: Text.ElideRight
            }

            Rectangle {
                color: "#00000000"
                Layout.fillWidth: true
            }

            Rectangle {
                color: "#00000000"
                Layout.preferredWidth: 2
            }

            ComboBox {
                id: __comboValueCombo

                model: _MODEL
                currentIndex: _CURRENT
                Layout.preferredWidth: _COMBO_SIZE
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                onAccepted: () => {
                    _CURRENT = __comboValueCombo.currentIndex;
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
