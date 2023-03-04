{
  users.groups.commonground = {};
  users.users.suwonp = {
    isNormalUser = true;
    home = "/home/suwonp";
    extraGroups = [ "networkmanager" "input" "uinput" "data" "commonground" ];
    hashedPassword = "$6$NVPZ8mxP39xJFpqi$fvFq/WTIJG62.AlcZftP29.xjTK1r6FP5re89OtyIX8nAk8PwfiEQTzdiWkITAP83fPH8p8csF3G7EnOJMWPN1";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO8oBIuYKU4sdtNsDd1WYqILQsHEEGrTw1oYY6APJejr sepiabrown@naver.com"
    ];
  };
}
