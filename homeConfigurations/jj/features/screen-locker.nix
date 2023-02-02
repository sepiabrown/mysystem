{ pkgs, ... }:
{
  services.screen-locker = {
    enable = true;
    inactiveInterval = 60; # min
    lockCmd = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 10 pixel";
  };
}
