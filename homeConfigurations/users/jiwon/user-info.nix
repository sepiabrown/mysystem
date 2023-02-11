{ config, lib, pkgs, userInfo, ... }:

{

  userInfo.name = "Jiwon Lee";
  userInfo.email = "leejiwon8433@gmail.com";

  home.username = "jiwon";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "22.11";

}
