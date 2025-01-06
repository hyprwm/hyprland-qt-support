set_source_files_properties(HyprlandStyle.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_qml_module(hyprland-quick-style-impl SHARED
    URI org.hyprland.style.impl
    VERSION 0.1
    QML_FILES
        HyprlandStyle.qml
        MotionBehavior.qml
)

install_qml_module(hyprland-quick-style-impl)
