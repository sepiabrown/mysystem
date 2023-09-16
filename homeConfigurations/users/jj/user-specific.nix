{ config, lib, pkgs, userInfo, ... }:

{
  imports = [
    ../../features/inputMethod/sebeolsik-391.nix
  ];

  userInfo.name = "JJ Kim";
  userInfo.email = "jj@haedosa.xyz";

  home.username = "jj";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "23.05";

}
