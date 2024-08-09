//@ pragma NativeTextRendering

import "./Settings"
import "./SidePanel"
import "./ui"
import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Fusion
import QtQuick.Layouts
import QtQuick.Window

ApplicationWindow {
    property var _WIDTH: 860
    property var _HEIGHT: 640
    property var _PADDING_TOP: 20
    property var _PADDING_SIDE: 7
    property var _SIDEBAR_SIZE: 220
    property var _SIDEBAR_RADIUS: 10
    property var _SIDEBAR_WIDTH: 5
    property var _CATEGORIES: [cat1, cat2, cat3]
    property var _CURRENT_CAT: 0

    function disableAllCats() {
        for (let i = 0; i < _CATEGORIES.length; ++i) {
            _CATEGORIES[i]._SELECTED = false;
        }
    }

    function selectCatByID(id) {
        if (id == _CURRENT_CAT)
            return ;

        disableAllCats();
        _CATEGORIES[id]._SELECTED = true; // TODO: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        __mainWindowCategoryStack.replaceCurrentItem(__mainWindowGeneralCategory);
        _CURRENT_CAT = id;
    }

    title: "Hyprland QML Style Tester"
    width: _WIDTH
    minimumWidth: _WIDTH
    maximumWidth: _WIDTH
    height: _HEIGHT
    minimumHeight: _HEIGHT
    maximumHeight: _HEIGHT
    visible: true
    color: system.base

    RowLayout {
        spacing: 0
        anchors.fill: parent

        Rectangle {
            Layout.preferredWidth: _PADDING_SIDE
            Layout.fillHeight: true
            color: system.base
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: _SIDEBAR_SIZE
            color: system.base

            ColumnLayout {
                anchors.left: parent.left
                anchors.leftMargin: _PADDING_SIDE
                spacing: 4

                Rectangle {
                    // pad
                    Layout.preferredHeight: _PADDING_TOP
                    color: "#00000000"
                }

                SideTitle {
                    _TEXT: "Hyprland Tester"
                }

                SideSeparator {
                }

                SideCategoryMarker {
                    _TEXT: "General"
                }

                SideButton {
                    id: cat1

                    _TEXT: "UI Elements"
                    _ICON: ""
                    _SELECTED: true
                    _ONCLICK: () => {
                        selectCatByID(0);
                    }
                }

                SideButton {
                    id: cat2

                    _TEXT: "Palette"
                    _ICON: "󰏘"
                    _ONCLICK: () => {
                        selectCatByID(1);
                    }
                }

                SideCategoryMarker {
                    _TEXT: "Advanced"
                }

                SideButton {
                    id: cat3

                    _TEXT: "Spacing"
                    _ICON: ""
                    _ONCLICK: () => {
                        selectCatByID(2);
                    }
                }

                Rectangle {
                    color: "#00000000"
                    Layout.fillHeight: true
                }

            }

            Item {
                // THIS IS BORKEN :(
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: 0
                width: _SIDEBAR_SIZE
                height: _HEIGHT

                Rectangle {
                    id: __sidePanelBorderFill

                    radius: _SIDEBAR_RADIUS
                    anchors.fill: parent
                    visible: false

                    gradient: Gradient {
                        orientation: Gradient.Horizontal

                        GradientStop {
                            position: 1
                            color: Qt.alpha(Qt.tint(system.mid, system.text), 0.3)
                        }

                        GradientStop {
                            position: 1
                            color: Qt.alpha(Qt.tint(system.mid, system.text), 0)
                        }

                    }

                }

                Rectangle {
                    id: __sidePanelRectangleMaskSource

                    radius: _SIDEBAR_RADIUS
                    border.width: _SIDEBAR_WIDTH
                    anchors.fill: parent
                    color: "#00000000"
                    visible: false
                }

                OpacityMask {
                    id: __sidePanelOpacityMask

                    anchors.fill: parent
                    source: __sidePanelBorderFill
                    maskSource: __sidePanelRectangleMaskSource
                }

            }

        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: _PADDING_SIDE * 1.5
            color: system.base
            radius: _SIDEBAR_RADIUS

            StackView {
                id: __mainWindowCategoryStack

                initialItem: __mainWindowGeneralCategory
                anchors.fill: parent

                replaceEnter: Transition {
                    PropertyAnimation {
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 200
                    }

                }

                replaceExit: Transition {
                    PropertyAnimation {
                        property: "opacity"
                        from: 1
                        to: 0
                        duration: 200
                    }

                }

            }

        }

    }

    Component {
        id: __mainWindowGeneralCategory

        Rectangle {
            color: "#00000000"

            GridLayout {
                columns: 2
                columnSpacing: 10
                rowSpacing: 20
                flow: GridLayout.LeftToRight
                layoutDirection: Qt.LeftToRight
                uniformCellHeights: false

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                SettingsCategory {
                    _TEXT: "Checkboxes"
                    Layout.fillWidth: true
                    Layout.preferredHeight: __gridColumn1.height

                    ColumnLayout {
                        id: __gridColumn1

                        spacing: 2
                        width: parent.width

                        Rectangle {
                            color: "#00000000"
                            Layout.preferredHeight: 6
                            Layout.fillWidth: true
                        }

                        CheckboxValue {
                            _TEXT: "Hyprlanding"
                            _HINT: "It's very cool!!!"
                            _CHECKED: true
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        CheckboxValue {
                            _TEXT: "Swaying"
                            _CHECKED: false
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        CheckboxValue {
                            _TEXT: "Testing"
                            _CHECKED: false
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        CheckboxValue {
                            _TEXT: "Testing 2"
                            _CHECKED: false
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        CheckboxValue {
                            _TEXT: "BLABLABLAH"
                            _HINT: "This is a loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong ass hint"
                            _CHECKED: false
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        Rectangle {
                            color: "#00000000"
                            Layout.preferredHeight: 6
                            Layout.fillWidth: true
                        }

                    }

                }

                SettingsCategory {
                    _TEXT: "Sliders"
                    Layout.fillWidth: true
                    Layout.preferredHeight: __gridColumn2.height

                    ColumnLayout {
                        id: __gridColumn2

                        spacing: 2
                        width: parent.width

                        Rectangle {
                            color: "#00000000"
                            Layout.preferredHeight: 6
                            Layout.fillWidth: true
                        }

                        SliderValue {
                            _TEXT: "Integer"
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        SliderValue {
                            _TEXT: "Float"
                            _MIN: -1
                            _MAX: 1
                            _CURRENT: 0
                            _DISPLAY_FN: (value) => {
                                return parseInt(value * 10) / 10;
                            }
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        SliderValue {
                            _TEXT: "Percentage"
                            _MIN: 0
                            _MAX: 1
                            _CURRENT: 0.5
                            _DISPLAY_FN: (value) => {
                                return parseInt(value * 100) + "%";
                            }
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        Rectangle {
                            color: "#00000000"
                            Layout.preferredHeight: 6
                            Layout.fillWidth: true
                        }

                    }

                }

                SettingsCategory {
                    _TEXT: "Combos"
                    Layout.fillWidth: true
                    Layout.preferredHeight: __gridColumn3.height

                    ColumnLayout {
                        id: __gridColumn3

                        spacing: 2
                        width: parent.width

                        Rectangle {
                            color: "#00000000"
                            Layout.preferredHeight: 6
                            Layout.fillWidth: true
                        }

                        ComboValue {
                            _TEXT: "Compositor"
                            _MODEL: ["Hyprland", "sway", "Wayfire"]
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        ComboValue {
                            _TEXT: "Style"
                            _MODEL: ["Cool", "uncool", "Windows"]
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        Rectangle {
                            color: "#00000000"
                            Layout.preferredHeight: 6
                            Layout.fillWidth: true
                        }

                    }

                }

                SettingsCategory {
                    _TEXT: "Spins"
                    Layout.fillWidth: true
                    Layout.preferredHeight: __gridColumn4.height

                    ColumnLayout {
                        id: __gridColumn4

                        spacing: 2
                        width: parent.width

                        Rectangle {
                            color: "#00000000"
                            Layout.preferredHeight: 6
                            Layout.fillWidth: true
                        }

                        SpinValue {
                            _TEXT: "Mode"
                            _CURRENT: 2
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        SpinValue {
                            _TEXT: "Type"
                            _CURRENT: 1
                            _MAX: 10
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        SpinValue {
                            _TEXT: "Gangsta"
                            _CURRENT: 2
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        Rectangle {
                            color: "#00000000"
                            Layout.preferredHeight: 6
                            Layout.fillWidth: true
                        }

                    }

                }

                SettingsCategory {
                    _TEXT: "Textboxes"
                    Layout.fillWidth: true
                    Layout.preferredHeight: __gridColumn5.height

                    ColumnLayout {
                        id: __gridColumn5

                        spacing: 2
                        width: parent.width

                        Rectangle {
                            color: "#00000000"
                            Layout.preferredHeight: 6
                            Layout.fillWidth: true
                        }

                        ShortTextValue {
                            _TEXT: "Web"
                            _CURRENT: "Anonymous"
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        ShortTextValue {
                            _TEXT: "IP"
                            _CURRENT: "192.168.1.1"
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        ShortTextValue {
                            _TEXT: "Mother name"
                            _CURRENT: "Dog"
                            Layout.fillWidth: true
                            Layout.preferredHeight: childrenRect.height
                        }

                        Rectangle {
                            color: "#00000000"
                            Layout.preferredHeight: 6
                            Layout.fillWidth: true
                        }

                    }

                }

            }

        }

    }

    SystemPalette {
        id: system

        colorGroup: SystemPalette.Active
    }

}
