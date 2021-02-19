{ config, pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  # programs.starship.settings = {
  #   # See docs here: https://starship.rs/config/
  #   # Symbols config configured in Flake.

  #   battery.display.threshold = 25; # display battery information if charge is <= 25%
  #   directory.fish_style_pwd_dir_length = 1; # turn on fish directory truncation
  #   directory.truncation_length = 2; # number of directories not to truncate
  #   gcloud.disabled = true; # annoying to always have on
  #   hostname.style = "bold green"; # don't like the default
  #   memory_usage.disabled = true; # because it includes cached memory it's reported as full a lot
  #   username.style_user = "bold blue"; # don't like the default
  # };
}
