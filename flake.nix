{
  description = "extra qt support libraries for the hyprland ecosystem";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
  };

  outputs = {
    self,
    nixpkgs,
    systems,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    eachSystem = lib.genAttrs (import systems);
    pkgsFor = eachSystem (
      system:
        import nixpkgs {
          localSystem = system;
          overlays = [self.overlays.default];
        }
    );
  in {
    overlays = import ./nix/overlays.nix { inherit inputs self lib; };

    packages = eachSystem (system: {
      default = self.packages.${system}.hyprland-qt-support;
      inherit (pkgsFor.${system}) hyprland-qt-support;
    });

    devShells = eachSystem (system: {
      default = import ./nix/shell.nix {
        pkgs = pkgsFor.${system};
        inherit (pkgsFor.${system}) hyprland-qt-support;
      };
    });
  };
}
