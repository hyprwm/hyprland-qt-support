import "../GlobalSettings"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Rectangle {
    property var _WIDTH: 200
    property var _HEIGHT: 5
    property var _MARGIN_HR: 20
    property var _THICKNESS: 1

    visible: true
    color: "#00000000"
    radius: 8
    implicitWidth: _WIDTH
    implicitHeight: _HEIGHT

    Rectangle {
        width: _WIDTH - 2 * _MARGIN_HR
        height: _THICKNESS
        color: system.mid
        anchors.centerIn: parent
    }

    SystemPalette {
        id: system

        colorGroup: SystemPalette.Active
    }

}
