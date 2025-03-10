{ config, inputs, userInfo, ... }:
let

  inherit (builtins) attrValues;
  inherit (inputs.self) homeManagerModules;
  overlays = attrValues inputs.self.overlays;

in
{

  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.nix-colors.homeManagerModule
  ] ++ (builtins.attrValues homeManagerModules);

  nixpkgs = {
    inherit overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [ # TODO: remove this
        "qtwebkit-5.212.0-alpha4"
        "tightvnc-1.3.10"
        "openssl-1.1.1v"
      ];
    };
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    # PATH = "$PATH:${builtins.getEnv "HOME"}/.emacs.d/bin:${builtins.getEnv "HOME"}/.radicle/bin";
  };


}
