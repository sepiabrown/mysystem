{ config, lib, pkgs, ... }:
{

  imports = [ ../../modules/nixos/frpc.nix ];

  services.frpc = {
    enable = true;
    serverAddress = "121.136.244.64";
    # customDomain = "giron.haedosa.xyz";
  };

}
