{ config, lib, pkgs, userInfo, ... }:

{

  userInfo.name = "JJ Kim";
  userInfo.email = "jj@haedosa.xyz";

  home.username = "jj";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "22.11";

}
