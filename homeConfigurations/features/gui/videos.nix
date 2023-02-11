{ pkgs, ... }:
{
  programs.mpv.enable = true;

  home.packages = with pkgs; [
    vlc
    obs-studio
    ffmpeg
    v4l-utils              # video4linux
  ];

}
