{ inputs, modulesPath, ... }:
let

  hds0-wireguard = import ../../features/wireguard.nix {
    name = "hds0";
    port = 51821;
    wg-key = ../../../secrets/wg-lima.age;
    wg-ips = [ "10.10.0.21/32" ];
    allowedIPs = [ "10.10.0.0/16" ];
  };

  hds1-wireguard = import ../../features/wireguard.nix {
    name = "hds1";
    port = 51820;
    wg-key = ../../../secrets/wg-lima.age;
    wg-ips = [ "20.20.0.21/32" ];
    allowedIPs = [ "20.20.0.0/16" ];
  };

in
{

  networking.hostName = "lima";

  imports = [

    # hardware
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    ../../features/intel-12gen-igpu.nix

    # bootloader
    ./bootloader.nix

    # kernel
    ./kernel.nix

    # file systems
    ../../fileSystems/encrypted-root.nix
    ../../fileSystems/btrfs.nix
    # ../../fileSystems/persistence.nix

    # host agnostic standard configurations
    ../../users
    ../../standard/configuration.nix

    # wireguard networks
    hds0-wireguard
    hds1-wireguard

    # hds0 binary caches
    ../../features/substituters/hds0.nix

    # features
    ../../features/xserver.nix
    ../../features/avahi.nix
    ../../features/dropbox.nix
    ../../features/syncthing.nix
    ../../features/remote-build.nix
    ../../features/quietboot
    ../../features/peerix.nix

  ];

}
