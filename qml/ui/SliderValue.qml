import "../GlobalSettings"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Rectangle {
    property string _TEXT: "Sample Slider"
    property string _HINT: ""
    property var _FONT_SIZE: 11
    property var _SLIDER_SIZE: 150
    property var _HEIGHT: 30
    property var _MIN: 0
    property var _MAX: 100
    property var _CURRENT: 50
    property var _STEP: 1
    property var _DISPLAY_FN: (value) => {
        return parseInt(value);
    }

    visible: true
    color: "#00000000"

    MouseArea {
        id: __sliderMouseArea

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
                ToolTip.visible: __sliderMouseArea.containsMouse && _HINT != ""
                ToolTip.text: _HINT
                ToolTip.delay: 400
                elide: Text.ElideRight
            }

            Rectangle {
                color: "#00000000"
                Layout.fillWidth: true
            }

            Text {
                font.pointSize: _FONT_SIZE - 2
                text: _DISPLAY_FN(_CURRENT)
                color: system.text
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
            }

            Rectangle {
                color: "#00000000"
                Layout.preferredWidth: 2
            }

            Slider {
                id: __sliderValueSlider

                from: _MIN
                to: _MAX
                value: _CURRENT
                snapMode: Slider.SnapAlways
                Layout.preferredWidth: _SLIDER_SIZE
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                onMoved: () => {
                    _CURRENT = __sliderValueSlider.value;
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
