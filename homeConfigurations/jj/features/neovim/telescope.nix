{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = telescope-nvim;
      type = "lua";
      config = /* lua */ ''
        local telescopebuiltin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>F', telescopebuiltin.find_files, {})
      '';
    }
    {
      plugin = telescope-manix;
      type = "lua";
      config = /* lua */ ''
        telescope.load_extension('manix')
      '';
    }
  ];
}
