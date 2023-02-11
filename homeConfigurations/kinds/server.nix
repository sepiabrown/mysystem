{ inputs, lib, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
in
{

  imports = [

    # base home configurations
    ./base.nix

    # cli applications
    ../features/cli

    # nix related tools
    ../features/nix.nix

    # editors of my choice
    ../features/doom-emacs
    ../features/neovim

  ];

  colorscheme = lib.mkDefault colorSchemes.dracula;
}
