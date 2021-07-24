{

  description = "My Wallpapers for 1366 pixel width";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-20.09";
    flake-utils.url = "github:numtide/flake-utils/master";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }: {

    overlay = import ./overlay.nix;

  } //
  flake-utils.lib.eachDefaultSystem (system:

    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
      };
    in {

      # overlay = import ./overlay.nix {};
      defaultPackage = pkgs.mywallpapers-1366;
    }

  );

}
