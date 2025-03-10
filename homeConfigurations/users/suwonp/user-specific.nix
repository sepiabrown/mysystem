{ config, lib, pkgs, userInfo, ... }:

{

  imports = [
    ../../features/inputMethod/sebeolsik-390.nix
    ./dotfiles/homemanager_basic.nix
  ];

  userInfo.name = "Suwon Park";
  userInfo.email = "suwonpark@haedosa.xyz";

  home.username = "suwonp";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "22.11";

}
