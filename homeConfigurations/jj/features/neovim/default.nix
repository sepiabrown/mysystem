{ config, pkgs, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-surround
      {
        plugin = telescope-nvim;
        type = "lua";
        config = /* lua */ ''
          local telescopebuiltin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>F', telescopebuiltin.find_files, {})
        '';
      }
    ];
  };

}
