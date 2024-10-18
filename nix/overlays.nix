{
  inputs,
  self,
  lib,
}: let
  mkDate = longDate: (lib.concatStringsSep "-" [
    (builtins.substring 0 4 longDate)
    (builtins.substring 4 2 longDate)
    (builtins.substring 6 2 longDate)
  ]);
  date = mkDate (self.lastModifiedDate or "19700101");
  version = lib.removeSuffix "\n" (builtins.readFile ../VERSION);
in {
  default = self.overlays.hyprland-qt-support;

  hyprland-qt-support = lib.composeManyExtensions [
    (final: prev: {
      hyprland-qt-support = final.callPackage ./. {
        version = "${version}+date=${date}_${self.shortRev or "dirty"}";
      };
    })
  ];
}
