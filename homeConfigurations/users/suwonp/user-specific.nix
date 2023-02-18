{ config, lib, pkgs, userInfo, ... }:

{

  imports = [
    ../../features/inputMethod/sebeolsik-390.nix
    ./dotfiles/homemanager_basic.nix
    ./dotfiles/homemanager_optional.nix
  ];

  userInfo.name = "Suwon Park";
  userInfo.email = "sepiabrown@naver.com";

  home.packages = with pkgs; [
    vimHugeX
    firefox
  ];

  home.username = "suwonp";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "22.11";

}
