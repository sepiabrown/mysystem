{

  description = "my system configurations using nix";

  inputs = {

    haedosa.url = "github:haedosa/flakes";
    nixpkgs.follows = "haedosa/nixpkgs-23-05";
    home-manager.follows = "haedosa/home-manager-23-05";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    impermanence.url = "github:nix-community/impermanence";

    nur.url = "github:nix-community/NUR";

    agenix.url = "github:ryantm/agenix";

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs = {
      url = "github:sepiabrown/nix-doom-emacs/adding_jjdosa_nix_community";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    myxmonad.url = "github:jjdosa/myxmonad";

    peerix = {
      url = "github:cid-chan/peerix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emanote.url = "github:EmaApps/emanote";

    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-melt.url = "github:nix-community/nix-melt";

    nix-visualize.url = "github:craigmbooth/nix-visualize";
    nix-visualize.flake = false;

    giter.url = "gitlab:refaelsh/giter";
    giter.flake = false;

  };

  outputs = inputs@{ nixpkgs, ... }:
  let

    inherit (nixpkgs.lib) genAttrs;
    supportedSystems = [ "x86_64-linux" ];
    forAllSystems = genAttrs supportedSystems;
    pkgsFor = system: import ./pkgs.nix { inherit inputs system; };

  in
  rec {

    pkgs = forAllSystems (system: pkgsFor system);

    overlays = import ./overlays;

    nixosModules = import ./modules/nixos;

    homeManagerModules = import ./modules/home-manager;

    packages = forAllSystems (import ./packages inputs);

    apps = forAllSystems (system: (import ./apps {
      pkgs = pkgsFor system; inherit nixosConfigurations homeConfigurations; }));

    devShells = forAllSystems (system: {
      default = import ./shell.nix { pkgs = pkgsFor system; };
    });

    nixosConfigurations = import ./nixosConfigurations inputs;

    homeConfigurations = import ./homeConfigurations inputs;

    deploy = import ./deploy inputs;

  };

}
