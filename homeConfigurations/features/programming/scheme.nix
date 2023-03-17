{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chicken
    guile
    racket
  ];
  # services.syncthing.enable = true;
}
