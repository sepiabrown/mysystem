{ config, lib, pkgs, userInfo, ... }:

{
  imports = [
    ../../features/inputMethod/sebeolsik.nix
  ];

  userInfo.name = "JJ Kim";
  userInfo.email = "jj@haedosa.xyz";

  home.username = "jj";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "22.11";

}
