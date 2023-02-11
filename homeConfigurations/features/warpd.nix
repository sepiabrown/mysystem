{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.warpd
  ];

  xsession.enable = true;
  xsession.initExtra = ''
    warpd
  '';

}
