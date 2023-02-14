{ config, lib, pkgs, userInfo, ... }:

{

  imports = [
    ../../features/inputMethod/sebeolsik-390.nix
  ];

  userInfo.name = "Suwon Park";
  userInfo.email = "sepiabrown@naver.com";

  home.username = "suwonp";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "22.11";

}
