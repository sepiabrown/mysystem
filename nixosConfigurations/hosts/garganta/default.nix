{ config, ... }:

{

  imports = [
    ../../users
    ../../fileSystems/btrfs.nix
    ../../basic/configuration.nix
    ../../basic/nix.nix
  ];

  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-label/root_crypt";
      preLVM = true;
    };
  };

  networking.hostName = "garganta";

}
