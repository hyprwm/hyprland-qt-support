import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import org.hyprland.style.impl

ApplicationWindow {
    id: window
    visible: true

    ScrollView {
        anchors.fill: parent
        ColumnLayout {
            RowLayout {
                component SettingSlider: ColumnLayout {
                    property alias text: label.text
                    property alias from: slider.from
                    property alias to: slider.to
                    property alias value: slider.value

                    Label {
                        id: label
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Slider {
                        id: slider
                        implicitWidth: 100
                    }
                }

                ComboBox {
                    model: ["Sharp", "Slightly Round", "Round", "Very Round"]

                    Component.onCompleted: {
                        this.currentIndex = HyprlandStyle.roundness;
                        HyprlandStyle.roundness = Qt.binding(() => this.currentIndex);
                    }
                }

                ComboBox {
                    model: ["No Border", "Thin", "Thick"]

                    Component.onCompleted: {
                        this.currentIndex = HyprlandStyle.borderWidth;
                        HyprlandStyle.borderWidth = Qt.binding(() => this.currentIndex);
                    }
                }

                CheckBox {
                    text: "Reduce motion"

                    Component.onCompleted: {
                        this.checkState = HyprlandStyle.reduceMotion ? Qt.Checked : Qt.Unchecked
                        HyprlandStyle.reduceMotion = Qt.binding(() => this.checkState == Qt.Checked);
                    }
                }
            }

            RowLayout {
                ColumnLayout {
                    Layout.maximumWidth: 300
                    Label { text: "Palette" }

                    SystemPalette { id: activePalette; colorGroup: SystemPalette.Active }
                    SystemPalette { id: inactivePalette; colorGroup: SystemPalette.Inactive }
                    SystemPalette { id: disabledPalette; colorGroup: SystemPalette.Disabled }

                    component PaletteColor: Rectangle {
                        required property string name;
                        required property var cg;
                        implicitWidth: 50
                        implicitHeight: 20
                        color: cg[name]
                    }

                    component PaletteItem: RowLayout {
                        id: pi

                        property alias text: label.text
                        property string color;

                        Label {
                            id: label
                            Layout.fillWidth: true
                        }

                        PaletteColor { name: pi.color; cg: activePalette }
                        PaletteColor { name: pi.color; cg: inactivePalette }
                        PaletteColor { name: pi.color; cg: disabledPalette }
                    }

                    PaletteItem { text: "Light"; color: "light" }
                    PaletteItem { text: "Midlight"; color: "midlight" }
                    PaletteItem { text: "Button"; color: "button" }
                    PaletteItem { text: "Window"; color: "window" }
                    PaletteItem { text: "Mid"; color: "mid" }
                    PaletteItem { text: "Dark"; color: "dark" }
                    PaletteItem { text: "Base"; color: "base" }
                    PaletteItem { text: "Text"; color: "text" }
                    PaletteItem { text: "Button Text"; color: "buttonText" }
                    PaletteItem { text: "Window Text"; color: "windowText" }
                    PaletteItem { text: "Highli Text"; color: "highlightedText" }
                    PaletteItem { text: "Placeholder"; color: "placeholderText" }
                    PaletteItem { text: "Shadow"; color: "shadow" }
                    PaletteItem { text: "Highlight"; color: "highlight" }
                    PaletteItem { text: "Accent"; color: "accent" }
                }

                ColumnLayout {
                    Layout.maximumWidth: 200
                    Label { text: "Button" }

                    component TestButton: Button { Layout.fillWidth: true }

                    TestButton { text: "Normal" }
                    TestButton { text: "Flat"; flat: true; }
                    TestButton { text: "Highlighted"; highlighted: true }
                    TestButton { text: "Flat Highlighted"; flat: true; highlighted: true }
                    TestButton { text: "Checked"; checkable: true; checked: true }
                    TestButton { text: "Flat Checked"; flat: true; checkable: true; checked: true }
                    TestButton { text: "Down"; down: true }
                    TestButton { text: "Flat Down"; flat: true; down: true }
                    TestButton { text: "Disabled"; enabled: false }
                    TestButton { text: "With Icon"; icon.name: "folder" }
                    TestButton { text: "With Mirror Icon"; icon.name: "folder"; LayoutMirroring.enabled: true }
                    TestButton { icon.name: "folder" }
                    Item { Layout.fillHeight: true }
                }

                ColumnLayout {
                    Layout.maximumWidth: 200
                    Label { text: "CheckBox" }

                    component TestCB: CheckBox { Layout.fillWidth: true }

                    TestCB { text: "Normal" }
                    TestCB { text: "Down"; down: true }
                    TestCB { text: "Mirrored"; LayoutMirroring.enabled: true }
                    TestCB { text: "Checked"; checked: true }
                    TestCB { text: "Partially Checked"; tristate: true; checkState: Qt.PartiallyChecked }
                    TestCB { text: "Disabled"; enabled: false }
                    Item { Layout.fillHeight: true }
                }

                ColumnLayout {
                    Layout.maximumWidth: 200
                    Label { text: "TextField" }

                    component TestField: TextField { Layout.fillWidth: true }

                    TestField { text: "Normal" }
                    TestField { text: "Disabled"; enabled: false }
                    TestField { placeholderText: "Placeholder" }
                    TestField { placeholderText: "Placeholder"; enabled: false }
                    Item { Layout.fillHeight: true }
                }

                Item { Layout.fillWidth: true }
            }
        }
    }
}
