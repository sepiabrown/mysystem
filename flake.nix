{

  description = "my system configurations using nix";

  inputs = {

    # haedosa.url = "github:haedosa/flakes";
    # nixpkgs.follows = "haedosa/nixpkgs";
    # home-manager.follows = "haedosa/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";

    impermanence.url = "github:nix-community/impermanence";

    nur.url = "github:nix-community/NUR";
    jupyter_contrib_core = {
      url = "github:Jupyter-contrib/jupyter_contrib_core";
      flake = false;
    };
    jupyter_nbextensions_configurator = {
      url = "github:Jupyter-contrib/jupyter_nbextensions_configurator";
      flake = false;
    };
    agenix.url = "github:ryantm/agenix";

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    doom-private.url = "github:jjdosa/doom-private";
    doom-private.flake = false;

    nix-doom-emacs = {
      url = "github:jjdosa/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.doom-private.follows = "doom-private";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    myxmonad.url = "github:jjdosa/myxmonad";

    peerix = {
      url = "github:cid-chan/peerix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emanote.url = "github:EmaApps/emanote";

  };

  outputs = inputs@{ nixpkgs, ... }:
  let

    inherit (nixpkgs.lib) genAttrs;
    supportedSystems = [ "x86_64-linux" ];
    forAllSystems = genAttrs supportedSystems;
    pkgsFor = system: import ./pkgs.nix { inherit inputs system; };

  in
  {

    overlays = import ./overlays;

    nixosModules = import ./modules/nixos;

    homeManagerModules = import ./modules/home-manager;

    packages = forAllSystems (import ./packages inputs);

    devShells = forAllSystems (system: {
      default = import ./shell.nix { pkgs = pkgsFor system; };
    });

    nixosConfigurations = import ./nixosConfigurations inputs;

    homeManagerConfigurations = import ./homeManagerConfigurations inputs;

    deploy = import ./deploy inputs;

  };

}
