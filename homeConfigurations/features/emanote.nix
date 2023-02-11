{ inputs, config, pkgs, ... }: let

  emanote = inputs.emanote.packages.${pkgs.system}.default;

in {
  imports = [
    inputs.emanote.homeManagerModule
  ];

  services.emanote = {
    enable = true;
    package = emanote;
    host = "127.0.0.1";
    port = 7000;
    notes = [
      "${config.home.homeDirectory}/Dropbox/Notes"
    ];
  };

}
