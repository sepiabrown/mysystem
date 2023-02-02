{ inputs, pkgs, ... }:

{

  imports = [
    inputs.nix-doom-emacs.hmModule
  ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ../../../../packages/doom-private;
    doomPackageDir = pkgs.linkFarm "my-doom-packages" [
      # straight needs a (possibly empty) `config.el` file to build
      { name = "config.el"; path = pkgs.emptyFile; }
      { name = "init.el"; path = ../../../../packages/doom-private/init.el; }
      { name = "packages.el"; path = ../../../../packages/doom-private/packages.el; }
    ];
  };

}
