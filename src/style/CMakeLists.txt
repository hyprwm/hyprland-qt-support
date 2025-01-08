add_subdirectory(impl)

qt_add_qml_module(hyprland-quick-style SHARED
    URI org.hyprland.style
    VERSION 0.1
    PLUGIN_TARGET hyprland-quick-styleplugin
    NO_PLUGIN_OPTIONAL
    NO_GENERATE_PLUGIN_SOURCE
    CLASS_NAME HyprlandQuickStylePlugin
    IMPORTS
        org.hyprland.style.impl
        QtQuick.Controls.Basic
    QML_FILES
        Button.qml
        CheckBox.qml
)

target_sources(hyprland-quick-styleplugin PRIVATE plugin.cpp)
target_link_libraries(hyprland-quick-styleplugin PRIVATE Qt::Gui)

target_link_libraries(hyprland-quick-style PRIVATE hyprland-quick-style-impl)

install_qml_module(hyprland-quick-style)

if (BUILD_TESTER)
    add_subdirectory(test)
endif()
