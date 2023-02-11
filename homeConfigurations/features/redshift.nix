{ pkgs, ... }:
{
  home.packages = with pkgs; [
    redshift
  ];
  services.redshift = {

    enable = true;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
    temperature.day = 5500;
    temperature.night = 4500;

    settings.redshift.brightness-day = "1.0";
    settings.redshift.brightness-night = "1.0";
    # latitude = "0.0000";
    # longitude = "0.0000";
    provider = "geoclue2";

  };
}
