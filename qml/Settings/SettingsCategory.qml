import "../GlobalSettings"
import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Rectangle {
    id: __settingsCategoryMain

    property var _OUTLINE_THICKNESS: 1
    property var _FONT_NO_LINE_MARGIN: 10
    property var _FONT_SIZE: 11
    property var _TEXT: "Sample Category"

    visible: true
    color: "#00000000"

    Rectangle {
        id: __settingsCategoryBorder
        anchors.fill: parent
        anchors.margins: 0
        visible: false
        color: "#00000000"
        radius: 8

        border {
            color: Qt.alpha(system.text, 0.9)
            width: _OUTLINE_THICKNESS
            pixelAligned: true
        }

    }

    Rectangle {
        id: __settingsCategoryMask

        visible: false
        anchors.fill: parent
        color: "#00000000"

        Rectangle {
            width: __settingsCategoryText.width + _FONT_NO_LINE_MARGIN
            height: __settingsCategoryText.height
            color: "black"

            anchors {
                verticalCenter: parent.top
                horizontalCenter: parent.horizontalCenter
            }

        }

    }

    OpacityMask {
        anchors.fill: parent
        anchors.margins: 0
        source: __settingsCategoryBorder
        maskSource: __settingsCategoryMask
        invert: true
    }

    Text {
        id: __settingsCategoryText

        text: _TEXT
        color: system.text
        font.pointSize: _FONT_SIZE

        anchors {
            verticalCenter: parent.top
            horizontalCenter: parent.horizontalCenter
        }

    }

    SystemPalette {
        id: system

        colorGroup: SystemPalette.Active
    }

}
