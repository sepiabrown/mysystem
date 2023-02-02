{ config, pkgs, inputs, ... }:
let neovim-overlay = inputs.neovim-nightly-overlay.packages.${pkgs.system};
in
{
  imports = [
    # ./telescope.nix
  ];

  programs.neovim = {
    enable = true;
    package = neovim-overlay.neovim;

    plugins = with pkgs.vimPlugins; [

      # Misc
      vim-surround
    ];
  };

}
