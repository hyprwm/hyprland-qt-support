qt_add_executable(style-test main.cpp)

qt_add_qml_module(style-test
    URI org.hyprland.style.test
    IMPORTS
        org.hyprland.style
    QML_FILES
        main.qml
)

target_link_libraries(style-test PRIVATE
    Qt::Quick Qt::QuickControls2
    hyprland-quick-style
)
