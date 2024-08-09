import "../GlobalSettings"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Rectangle {
    property string _TEXT: "Sample Spin"
    property string _HINT: ""
    property var _FONT_SIZE: 11
    property var _SPIN_SIZE: 50
    property var _HEIGHT: 30
    property var _MIN: 0
    property var _MAX: 3
    property var _CURRENT: 2

    visible: true
    color: "#00000000"

    MouseArea {
        id: __spinMouseArea

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
                ToolTip.visible: __spinMouseArea.containsMouse && _HINT != ""
                ToolTip.text: _HINT
                ToolTip.delay: 400
                elide: Text.ElideRight
            }

            Rectangle {
                color: "#00000000"
                Layout.fillWidth: true
            }

            SpinBox {
                id: __spinValueSpin

                from: _MIN
                to: _MAX
                value: _CURRENT
                Layout.preferredWidth: _SPIN_SIZE
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                onValueModified: () => {
                    _CURRENT = __spinValueSpin.value;
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
