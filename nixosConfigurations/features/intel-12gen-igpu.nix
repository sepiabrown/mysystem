{

  # see https://discourse.nixos.org/t/intel-12th-gen-igpu-freezes/21768/5
  services.xserver.videoDrivers = [ "modesetting" ];

  boot.kernelParams = [
    "i915.enable_psr=1"
  ];

}
