{ inputs, modulesPath, ... }:
let

  hds0-wireguard = import ../../features/wireguard.nix {
    name = "hds0";
    port = 51821;
    wg-key = ../../../secrets/wg-bogota.age;
    wg-ips = [ "10.10.0.22/32" ];
    allowedIPs = [ "10.10.0.0/16" ];
  };

  hds1-wireguard = import ../../features/wireguard.nix {
    name = "hds1";
    port = 51820;
    wg-key = ../../../secrets/wg-bogota.age;
    wg-ips = [ "20.20.0.22/32" ];
    allowedIPs = [ "20.20.0.0/16" ];
  };

in
{

  networking.hostName = "bogota";

  imports = [

    # hardware
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd

    # bootloader
    ./bootloader.nix

    # kernel
    ./kernel.nix

    # file systems
    ../../fileSystems/ext4.nix

    # host agnostic standard configurations
    ../../users
    ../../standard/configuration.nix

    # wireguard networks
    hds0-wireguard
    hds1-wireguard

    # features
    ../../features/xserver.nix
    ../../features/avahi.nix
    ../../features/dropbox.nix
    ../../features/syncthing.nix
    ../../features/substituters/hds0.nix
    ../../features/remote-build.nix
    ../../features/peerix.nix
    ../../features/nvidia-prime.nix

  ];

}
