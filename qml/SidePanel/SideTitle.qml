import "../GlobalSettings"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Rectangle {
    property string _TEXT: "Sample Text"
    property var _WIDTH: 200
    property var _HEIGHT: 40
    property var _FONT_SIZE: 16

    visible: true
    color: "#00000000"
    radius: 8
    implicitWidth: _WIDTH
    implicitHeight: _HEIGHT

    Text {
        font.pointSize: _FONT_SIZE
        text: _TEXT
        color: system.text
        anchors.centerIn: parent
    }

    SystemPalette {
        id: system

        colorGroup: SystemPalette.Active
    }

}
