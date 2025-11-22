{
  lib,
  stdenv,
  cmake,
  ninja,
  qt6,
  pkg-config,
  hyprlang,
  version ? "0",
self,
}:
stdenv.mkDerivation {
  pname = "hyprland-qt-support";
  inherit version;

  src = self;

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtsvg
    qt6.qtwayland
    hyprlang
  ];

  cmakeFlags = [
    (lib.cmakeFeature "INSTALL_QML_PREFIX" qt6.qtbase.qtQmlPrefix)
  ];

  meta = {
    description = "hyprland-qt-support";
    homepage = "https://github.com/hyprwm/hyprland-qt-support";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.linux;
  };
}
