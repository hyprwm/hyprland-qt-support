qt_add_qml_module(hyprland-quick-style
    URI org.hyprland.style
    VERSION 0.1
    IMPORTS QtQuick.Controls.Basic
    QML_FILES
        Button.qml
)

install_qml_module(hyprland-quick-style)
