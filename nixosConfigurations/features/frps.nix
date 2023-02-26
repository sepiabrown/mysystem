{ config, lib, pkgs, ... }:
{

  imports = [ ../../modules/nixos/frps.nix ];

  services.frps = {
    enable = true;
    serverAddress = "121.136.244.64";
  };

}
