{ config, pkgs , lib , ... }:

{

  programs.home-manager.enable = true;
  xdg.enable = true;

  imports = [
    ../programs/alacritty
    ../programs/fish
    ../programs/zsh
    ../programs/starship
    ../programs/fzf
    ../programs/broot
    ../programs/direnv
    ../programs/htop
    ../programs/bat
    ../programs/gpg
    ../programs/jq
    ../programs/ssh
    ../programs/git
    ../programs/zathura
    ../services/email
  ] ++
  lib.filter lib.pathExists [
    ./private.nix
  ];


  home.packages = with pkgs; [
    file
    fd
    ncdu
    du-dust
    exa
    ripgrep
    any-nix-shell
    prettyping
    diff-so-fancy
    gnused
    coreutils
    neofetch
    youtube-dl
    syncthing
    rnix-lsp
    imagemagick
    pass

    myemacs
    myvim
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    # PATH = "$PATH:${builtins.getEnv "HOME"}/.emacs.d/bin:${builtins.getEnv "HOME"}/.radicle/bin";
  };


  # You can update Home Manager without changing this value. See the Home Manager release notes for
  # a list of state version changes in each release.
  home.stateVersion = "21.03";

}
