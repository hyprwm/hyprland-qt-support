set_source_files_properties(HyprlandStyle.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_library(hyprland-quick-style-impl SHARED
    hyprlandstyle.cpp
    checkdelegate.cpp
)

qt_add_qml_module(hyprland-quick-style-impl
    URI org.hyprland.style.impl
    VERSION 0.1
    QML_FILES
        HyprlandStyle.qml
        MotionBehavior.qml
)

target_link_libraries(hyprland-quick-style-impl PRIVATE Qt::Quick hyprlang)

install_qml_module(hyprland-quick-style-impl)
