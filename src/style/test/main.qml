import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import org.hyprland.style.impl

ApplicationWindow {
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

                SettingSlider {
                    text: "Radius"
                    from: 0
                    to: 30

                    Component.onCompleted: {
                        this.value = HyprlandStyle.radius
                        HyprlandStyle.radius = Qt.binding(() => this.value)
                    }
                }

                SettingSlider {
                    text: "Border width"
                    from: 0
                    to: 5

                    Component.onCompleted: {
                        this.value = HyprlandStyle.borderWidth
                        HyprlandStyle.borderWidth = Qt.binding(() => this.value)
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
                    Layout.maximumWidth: 200
                    Label { text: "Button" }

                    component TestButton: Button { Layout.fillWidth: true }

                    TestButton { text: "Normal" }
                    TestButton { text: "Flat"; flat: true; }
                    TestButton { text: "Highlighted"; highlighted: true }
                    TestButton { text: "Flat Highlighted"; flat: true; highlighted: true }
                    TestButton { text: "Checked"; checked: true }
                    TestButton { text: "Flat Checked"; flat: true; checked: true }
                    TestButton { text: "Down"; down: true }
                    TestButton { text: "Flat Down"; flat: true; down: true }
                }

                Item { Layout.fillWidth: true }
            }
        }
    }
}
