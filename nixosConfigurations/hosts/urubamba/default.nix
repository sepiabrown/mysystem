{ inputs, modulesPath, ... }:
let

  hds0-wireguard = import ../../features/wireguard.nix {
    name = "hds0";
    port = 51821;
    wg-key = ../../../secrets/wg-urubamba.age;
    wg-ips = [ "10.10.0.2/32" ];
    allowedIPs = [ "10.10.0.0/16" ];
  };

  hds1-wireguard = import ../../features/wireguard.nix {
    name = "hds1";
    port = 51820;
    wg-key = ../../../secrets/wg-urubamba.age;
    wg-ips = [ "20.20.0.2/32" ];
    allowedIPs = [ "20.20.0.0/16" ];
  };

in
{

  networking.hostName = "urubamba";

  imports = [

    # hardware
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    # ../../features/intel-12gen-igpu.nix

    # bootloader
    #./bootloader.nix
    ./hardware-configuration.nix
    ./zfs.nix

    # kernel
    ./kernel.nix

    # file systems
    #../../fileSystems/ext4.nix

    # host agnostic standard configurations
    ../../users
    ../../users/suwonp.nix
    ../../standard/configuration.nix

    # wireguard networks
    #hds0-wireguard
    #hds1-wireguard

    # features
    ../../features/xserver.nix
    ../../features/avahi.nix
    # ../../features/dropbox.nix
    # ../../features/syncthing.nix
    #../../features/substituters/hds0.nix
    #../../features/remote-build.nix
    ../../features/peerix.nix
    ../../features/virtualization.nix

  ];

  nix = {
    settings = {
      trusted-users = [ "suwonp" ];
    };
  };


  users.extraUsers.suwonp = {
    isNormalUser = true;
    home = "/home/suwonp";
    extraGroups = [ "wheel" "networkmanager" "input" "uinput" "data" ];
    hashedPassword = "$6$NVPZ8mxP39xJFpqi$fvFq/WTIJG62.AlcZftP29.xjTK1r6FP5re89OtyIX8nAk8PwfiEQTzdiWkITAP83fPH8p8csF3G7EnOJMWPN1";
    openssh.authorizedKeys.keys = [];
  };

}
