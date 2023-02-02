{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xcape
  ];
  services.xcape = {
    enable = true;
    timeout = 500;  # ms
    mapExpression = {
      # Shift_L   = "Escape";
      Caps_Lock = "Escape";
      Control_L = "Escape";
    };
  };
}
