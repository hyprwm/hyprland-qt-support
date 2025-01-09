{
  pkgs ? import <nixpkgs> {},
  hyprland-qt-support ? pkgs.callPackage ./default.nix {},
  ...
}:
pkgs.mkShell {
  inputsFrom = [hyprland-qt-support];
  nativeBuildInputs = [pkgs.clang-tools pkgs.parallel];

  shellHook = let
    inherit (pkgs.lib.strings) concatMapStringsSep;
    qtLibPath = f:
      concatMapStringsSep ":" f (with pkgs.qt6; [
        qtbase
        qtdeclarative
        qtwayland
      ]);
  in ''
    # Add Qt-related environment variables.
    export QT_PLUGIN_PATH=${qtLibPath (p: "${p}/lib/qt-6/plugins")}
    export QML2_IMPORT_PATH=${qtLibPath (p: "${p}/lib/qt-6/qml")}
  '';
}
