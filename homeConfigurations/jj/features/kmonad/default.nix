{ inputs, config, lib, pkgs, ... }:
let

  kmonad = inputs.kmonad.packages.${pkgs.system}.default;

  kmonadConfigs ={
    hhkb-usb = {
      kdbFile = ./hhkb.kbd;
      device = "/dev/input/by-id/usb-PFU_Limited_HHKB-Hybrid-event-kbd";
    };
    hhkb-blt = {
      kdbFile = ./hhkb.kbd;
      device = "/dev/input/event22";
    };
    x1 = {
      kdbFile = ./x1.kbd;
      device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
    };
    legion = {
      kdbFile = ./legion.kbd;
      device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
    };
  };

  kmonadScripts = lib.mapAttrs' (name: value: {
    name = "kmonad-${name}";
    value = pkgs.writeShellScriptBin "kmonad-${name}" (let
      kbd = pkgs.substitute {
        src = value.kdbFile;
        replacements = [ "--replace" "@device@" "${value.device}" "--replace" "@name@" "${name}"];
      };
    in "${kmonad}/bin/kmonad ${kbd}");
  }) kmonadConfigs;

  myxset = pkgs.writeShellScriptBin "myxset" "xset r rate 300 80";

in {

  home.packages = [
    kmonad
    myxset
  ] ++ builtins.attrValues kmonadScripts;

  xsession.enable = true;
  xsession.initExtra = ''
    kmonad-hhkb-usb &
    kmonad-hhkb-blt &
    kmonad-x1 &
    myxset
  '';

}
