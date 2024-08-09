import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import "../GlobalSettings"

Rectangle {
    property string _TEXT: "Sample Text"
    property string _ICON: ""
    property var _WIDTH: 200
    property var _HEIGHT: 30
    property var _SELECTED: false
    property var _ONCLICK: () => {}

    visible: true
    color: _SELECTED ? (__sideButtonMouseArea.containsMouse ? system.midlight : system.mid) : (__sideButtonMouseArea.containsMouse ? system.midlight : "#00000000")
    radius: 8
    implicitWidth: _WIDTH
    implicitHeight: _HEIGHT

    SystemPalette {
        id: system

        colorGroup: SystemPalette.Active
    }

    MouseArea {
        id: __sideButtonMouseArea

        hoverEnabled: true
        anchors.fill: parent
        onClicked: () => {
            _ONCLICK();
        }

        RowLayout {
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            anchors.left: parent.left

            Text {
                text: _ICON
                font.pointSize: 12
                color: system.windowText
                Layout.preferredWidth: 15
            }

            Text {
                text: _TEXT
                font.pointSize: 12
                color: system.windowText
            }

        }

    }

    Behavior on color {
        ColorAnimation {
            duration: 91 // FIXME: why are GlobalSettings not working :(
        }

    }

}
