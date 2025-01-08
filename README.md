## hyprland-qt-support

A qt6 qml style provider for hypr* apps.

## Building

You can build it with this command:
```sh
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DINSTALL_QML_PREFIX=/lib/qt6/qml -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
```

Please note the `INSTALL_QML_PREFIX` is _distro-specific_ and may differ.

For Arch, it's the same as in the example above, `/lib/qt6/qml`.

## Usage

Launch a qt/qml app with `QT_QUICK_CONTROLS_STYLE=org.hyprland.style`
