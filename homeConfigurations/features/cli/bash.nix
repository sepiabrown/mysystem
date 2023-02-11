{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    initExtra = ''
      ${pkgs.neofetch}/bin/neofetch
    '';
  };
}
