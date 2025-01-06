add_subdirectory(impl)

qt_add_qml_module(hyprland-quick-style SHARED
    URI org.hyprland.style
    VERSION 0.1
    IMPORTS
        org.hyprland.style.impl
        QtQuick.Controls.Basic
    QML_FILES
        Button.qml
)

install_qml_module(hyprland-quick-style)

add_subdirectory(test)
