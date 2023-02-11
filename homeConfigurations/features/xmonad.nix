{ inputs, pkgs, ... }:

{

  imports = [ inputs.myxmonad.homeManagerModules.default ];

  mysystem.windowManager.xmonad.enable = true;

  home.packages = [
    inputs.myxmonad.packages.${pkgs.system}.xmonad-restart
  ];

}
