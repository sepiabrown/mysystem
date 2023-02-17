{
  services.xserver = {
    enable = true;

    libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        naturalScrolling = true;
      };
      mouse = {
        disableWhileTyping = true;
        naturalScrolling = true;
      };
    };

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
}
