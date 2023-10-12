# Install nix
# - needs user account with sudo privilege
# - needs to add 'experimental-features = nix-command flakes' to nix.conf (generally found in ~/.config/nix)
#   - with nix-unstable-installer: https://github.com/numtide/nix-unstable-installer (recommended)
#   $ sh <(curl -L https://github.com/numtide/nix-unstable-installer/releases/download/nix-2.7.0pre20220127_558c4ee/install)
#
#########################################
#     - can install homemanager directly using flake.nix (maybe with unstableNix)
#########################################
#     $ nix-env --set-flag priority 6 nix
#     If flake-util is not appiled
#     $ nix build .#homeConfigurations.sepiabrown.activationPackage --extra-experimental-features flakes --extra-experimental-features nix-command
#     If flake-util is appiled
#     $ nix build .#homeConfigurations.x86_64-linux.sepiabrown.activationPackage --extra-experimental-features flakes --extra-experimental-features nix-command
#     OR
#     $ nix build .#homeConfigurations.x86_64-darwin.sepiabrown.activationPackage --extra-experimental-features flakes --extra-experimental-features nix-command
#     $ ./result/activate
#     $ home-manager switch --flake '<flake-uri>#jdoe'
#     $ fc-cache -f
#   - current priority
#     - nix-2.9 : 4
#     - home-manager-path : 5
#     - nix-2.7-pre : 6
#   - on non-NixOS Linux distro (using multi user installation)
#   $ sh <(curl -L https://nixos.org/nix/install) --daemon
#   - on macOS
#   $ sh <(curl -L https://nixos.org/nix/install)
#   - on Windows WSL2 (using single user installation)
#   $ sh <(curl -L https://nixos.org/nix/install) --no-daemon
#     - needs to install home-manager with nix-env and write nixUnstable in home.package
#   - on non-NixOS Linux distro without sudo privilige ex) CENTOS
#   $ yum makecache
#   $ yum -y install cargo
#   $ curl -L https://github.com/nix-community/nix-user-chroot/releases/download/1.2.2/nix-user-chroot-bin-1.2.2-x86_64-unknown-linux-musl
#   $ cargo install nix-user-chroot
#     - on ~/.nix
#     $ mkdir -m 0755 ~/.nix
#     $ setfacl -bnR .nix
#     $ nix-user-chroot ~/.nix bash -c "sh <(curl -L https://github.com/numtide/nix-unstable-installer/releases/download/nix-2.7.0pre20220127_558c4ee/install)"
#   log in again or type $ . /home/sepiabrown/.nix-profile/etc/profile.d/nix.sh
#
#     - not on ~/.nix
#     $ cargo install nix-user-chroot
#     $ mkdir -m 0755 .nix
#     $ setfacl -bnR .nix
#     $ nix-user-chroot ~/.nix bash -c "sh <(curl -L https://github.com/numtide/nix-unstable-installer/releases/download/nix-2.7.0pre20220127_558c4ee/install)"
#     $ nix-user-chroot ~/.nix bash -c "curl -L https://nixos.org/nix/install | bash"
#     log out and log in again with the below "Login procedure" and type
#     $ . /home/sepiabrown/.nix-profile/etc/profile.d/nix.sh
#     $ cd dotfiles
#     $ nix build .#homeConfigurations.sepiabrown.activationPackage --extra-experimental-features flakes --extra-experimental-features nix-command
#
#   - Login procedure
#   $ ssh -X -p 7777 -t sepiabrown@snubayes.duckdns.org "./.cargo/bin/nix-user-chroot ~/.nix bash -l"
#   $ unset HISTFILE
# After installing flake:
# $ git update-index --skip-worktree flake.lock
#
# search: https://rycee.gitlab.io/home-manager/options.html
# xsession.enable = true; # needed for graphical session related services such as xscreensaver

{ config, pkgs, lib, ... }:

{
  config = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isLinux {
      manual.manpages.enable = false;
      programs = {
        gpg = {
          enable = true;
        };

        chromium = {
          enable = true;
          extensions = [ "inomeogfingihgjfjlpeplalcfajhgai" ];
        };
      };

      services = {
        gpg-agent = {
          # enable = true;
          pinentryFlavor = "qt";
          # enableSshSupport = true;
          # defaultCacheTtl = pkgs.lib.mkForce 2592000; #== 30 days in seconds
          # defaultCacheTtlSsh = pkgs.lib.mkForce 2592000; #== 30 days in seconds
          maxCacheTtl = 3153600000; #== 100 years in seconds
          maxCacheTtlSsh = 3153600000; #== 100 years in seconds
        };
      };

      home.packages = with pkgs;
        [
          # system
          traceroute
          refind
          lvm2
          baobab # Disk Usage Analyser
          xautoclick
          sl
        ];
    })
    {
      nixpkgs.config.permittedInsecurePackages = [
        "openssl-1.1.1u"
      ];

      home.packages = with pkgs;
        [
          # test
          # hello

          # web
          lynx

          # keyboard
          xorg.xev
          xorg.xkbcomp
          xorg.xmodmap

          # system
          #(pkgs.writeScriptBin "nixFlakes" ''
          #  exec ${pkgs.nixUnstable}/bin/nix --experimental-features "nix-command flakes" "$@"
          #'')
          nixUnstable
          cargo
          wget
          curl
          dig
          ripgrep
          zip
          unzip
          gzip
          git-crypt
          pinentry_qt
          rclone
          file # show the file's type
          dua # Disk Usage
          duc # Disk Usage
          testdisk # data recovery software. recover lost partition, make non booting disk bootable again
          brightnessctl

          # dev
          poetry
          nixpkgs-fmt
        ];

      programs = {
        home-manager.enable = true;

        htop.enable = true;

        vim = {
          enable = true;
          extraConfig = ''
            set mouse=a
          '';
        };

        #alacritty = {
        #  enable = true;
        #  settings = {
        #    env.TERM = "xterm-256color";
        #    window.dimensions = {
        #      lines = 200;
        #      columns = 200;
        #    };
        #    # key_bindings = [
        #    #   {
        #    #     key = "K";
        #    #     mods = "Control";
        #    #     chars = "\\x0c";
        #    #   }
        #    # ];
        #  };
        #  # setting alacritty in another way
        #  # home.file = {
        #  #   ".config/alacritty/alacritty.yaml".text = ''
        #  #     env:
        #  #       TERM: xterm-256color
        #  #     window:
        #  #       dimensions:
        #  #         lines : 3
        #  #         columns : 200
        #  #     key_bindings:
        #  #       - { key: K, mods: Control, chars: "\x0c"  }
        #  #   '';
        #  # };
        #};

        #git = {
        #  enable = true;
        #  package = pkgs.gitAndTools.gitFull;
        #  userName = "Suwon Park";
        #  userEmail = "sepiabrown@naver.com";
        #};

        #gh = {
        #  enable = true;
        #  #gitProtocol = "ssh";
        #  settings.git_protocol = "ssh"; # after release-21.05
        #};

        direnv = {
          enable = true;
          nix-direnv = {
            enable = true;
            # optional for nix flakes support in home-manager 21.11, not required in home-manager unstable or 22.05
            #enableFlakes = true;
          };
        };

        bash = {
          enable = true;
          historyControl = [ "ignoredups" "ignorespace" ];
          #shellAliases = {
          #  ls = "ls --color=auto";
          #  grep = "grep --color=auto";
          #  fgrep = "fgrep --color=auto";
          #  egrep = "egrep --color=auto";
          #  ll = "ls -alF";
          #  la = "ls -A";
          #  l = "ls -CF";
          #  alert = "notify-send --urgency=low -i \"$([ $? = 0 ] && echo terminal || echo error)\" \"$(history|tail -n1|sed -e 's/^\\s*[0-9]\\+\\s*//;s/[;&|]\\s*alert$//')\"";
          #  #tmux = "tmux -S ~/.tmp";
          #}; # single quote needs less backslash!!! unintuitive!!!
          profileExtra = ''
            #echo "start profile"
            # if running bash
            if [ -n ''$BASH_VERSION ]; then
                # include .bashrc if it exists
                if [ -f ''$HOME/.bashrc ]; then
                    . ''$HOME/.bashrc
                fi
            fi

            # set PATH so it includes user's private bin if it exists
            if [ -d ''$HOME/bin ] ; then
                PATH=''$HOME/bin:''$PATH
            fi

            # set PATH so it includes user's private bin if it exists
            if [ -d ''$HOME/.local/bin ] ; then
                PATH=''$HOME/.local/bin:''$PATH
            fi

            export PATH

            if [ -e ''$HOME/.cargo/env ]; then . ''$HOME/.cargo/env; fi

            if [ -e ''$HOME/.nix-profile/etc/profile.d/nix.sh ]; then . ''$HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
            #echo "end profile"
          '';
          bashrcExtra = ''
            #echo "start bashrc"
            case $- in
                *i*) ;;
                  *) return;;
            esac

            [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

            [ -x /usr/bin/lesspipe.sh ] && eval "$(SHELL=/bin/sh lesspipe.sh)"

            if [ -z "''${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
                debian_chroot=''$(cat /etc/debian_chroot)
            fi

            case "''$TERM" in
                xterm-color|*-256color) color_prompt=yes;;
            esac

            #force_color_prompt=yes

            if [ -n "''$force_color_prompt" ]; then
                if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
                    # We have color support; assume it's compliant with Ecma-48
                    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
                    # a case would tend to support setf rather than setaf.)
                    color_prompt=yes
                else
                    color_prompt=
                fi
            fi

            if [ "''$color_prompt" = yes ]; then
                PS1="''${debian_chroot:+(''$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\''$ "
            else
                PS1="''${debian_chroot:+(''$debian_chroot)}\u@\h:\w\''$ "
            fi
            unset color_prompt force_color_prompt

            # If this is an xterm set the title to user@host:dir
            case "''$TERM" in
            xterm*|rxvt*)
                PS1="\[\e]0;''$\{debian_chroot:+(''$debian_chroot)\}\u@\h: \w\a\]''$PS1"
                ;;
            *)
                ;;
            esac

            if [ -f ~/.bash_aliases ]; then
                . ~/.bash_aliases
            fi

            if ! shopt -oq posix; then
              if [ -f /usr/share/bash-completion/bash_completion ]; then
                . /usr/share/bash-completion/bash_completion
              elif [ -f /etc/bash_completion ]; then
                . /etc/bash_completion
              fi
            fi

            if [ -e ''$HOME/.cargo/env ]; then . ''$HOME/.cargo/env; fi
            #echo "end bashrc"
          '';
        };

        dircolors.enable = true;

        # Reconnecting ssh made 'command not found' error in tmux.
        # Introducing socket did not help
        # Solution: When new session is made, detach and reattach once.
        #   To keep the session alive, quit the window holding tmux without detaching.(ex) via mouse click)
        #tmux = {
        #  enable = true;
        #  keyMode = "vi";
        #  #newSession = true;
        #  extraConfig = "set -g mouse on";
        #  historyLimit = 100000;
        #};
######################
# Not Tested on darwin
######################
        kitty = {
          enable = true;
          keybindings = {
            "ctrl+c" = "copy_or_interrupt";
            "ctrl+f>2" = "set_font_size 20";
            "f1" = "launch --stdin-source=@screen_scrollback --stdin-add-formatting less +G -R";
          };
          settings = {
            scrollback_lines = -1;
            enable_audio_bell = false;
            update_check_interval = 0;
            initial_window_width = "79c";
            initial_window_height = "24c";
            font_size = "14.0";
          };
          theme = "Space Gray Eighties";
        };
      };

      home.file = {
        "my.rclone".source = pkgs.writeScript "my_rclone" ''
          #!/usr/bin/env bash
          echo hi
          RCLONEPATHS="_mobile __inbox _참고자료 통계학"
          #RCLONEHOME= "/commonground/gd/"
          RCLONEHOME="/home/sepiabrown/gd/"
          RCLONEREMOTE="gd:"
          RCLONEREMOTE2="db:"
          FILTERFILEUPLOAD="/home/sepiabrown/filter-file-upload"
          FILTERFILEDOWNLOAD="/home/sepiabrown/filter-file-download"
          #rclone check "''${RCLONEREMOTE}" "''${RCLONEHOME}" --filter-from filter-file
          #IFS=','
          #for RCPATH in ''${RCLONEPATHS}
          #  do
          #    rclone check "''${RCLONEREMOTE}''${RCPATH}" "''${RCLONEHOME}''${RCPATH}" --filter-from filter-file
          #  done
          while true; do
            read -p "Choose Task (copy, sync, check, quit..) : " task
              if [ ''${task} == "quit" ]; then
                read -p "Press [Enter] key to end..."
                exit 1
              else
                read -p "Choose Direction (remote to local : r , local to remote : l, dropbox : d) : " direction
                read -p "Are you sure? : " safe
                if [ ''${task} == "check" -a ''${safe} == "y" ]; then
                  for RCPATH in $RCLONEPATHS; do
                    rclone check "''${RCLONEREMOTE}''${RCPATH}" "''${RCLONEHOME}''${RCPATH}" --filter-from "''${FILTERFILEDOWNLOAD}"
                  done
                elif [ ''${direction} == "r" -a ''${safe} == "y" ]; then
                  for RCPATH in $RCLONEPATHS; do
                    echo "''${RCLONEHOME}''${RCPATH}"
                    rclone mkdir "''${RCLONEHOME}''${RCPATH}"
                    rclone $task "''${RCLONEREMOTE}''${RCPATH}" "''${RCLONEHOME}''${RCPATH}" --backup-dir "''${RCLONEHOME}/tmp" --suffix .rclone --verbose --filter-from "''${FILTERFILEDOWNLOAD}"
                  done
                  #  rclone $task "''${RCLONEREMOTE}" "''${RCLONEHOME}" --backup-dir "''${RCLONEHOME}/tmp" --suffix .rclone --verbose --track-renames
                elif [ ''${direction} == "l" -a ''${safe} == "y" ]; then
                  for RCPATH in $RCLONEPATHS; do
                    rclone mkdir "''${RCLONEREMOTE}''${RCPATH}"
                    rclone $task "''${RCLONEHOME}''${RCPATH}" "''${RCLONEREMOTE}''${RCPATH}" --backup-dir "''${RCLONEREMOTE}/tmp" --suffix .rclone --verbose --filter-from "''${FILTERFILEUPLOAD}"
                  done
                  #  rclone $task "''${RCLONEHOME}" "''${RCLONEREMOTE}" --backup-dir "''${RCLONEREMOTE}/tmp" --suffix .rclone --verbose --track-renames
                elif [ ''${direction} == "d" -a ''${safe} == "y" ]; then
                  # for RCPATH in $RCLONEPATHS do
                    rclone $task "''${RCLONEHOME}_mobile/structured" "''${RCLONEREMOTE2}/_mobile/structured" --backup-dir "''${RCLONEREMOTE2}/tmp" --suffix .rclone --verbose --filter-from "''${FILTERFILEUPLOAD}"
                  # done
                else
                  read -p "Error : Press [Enter] key to end..."
                  exit 1
                fi
              fi
          done
        '';
        "apply-flake.sh".source = pkgs.writeScript "apply-flake_sh" ''
          #!/bin/sh
          # CONFIG_PATH="./system/configuration_current.nix"
          pushd ~/dotfiles
          if [ -z ''$1 ]; then
            echo "needs at least one command"
            # sudo nixos-rebuild switch -I nixos-config="''${CONFIG_PATH}" --flake .#
          elif [ -z ''$2 ]; then
            sudo nix flake update; sudo nixos-rebuild switch --flake ''$1
          else
            sudo nix flake update; sudo nix flake update & sudo nixos-rebuild switch --flake ''$1 -p ''$2 --show-trace
          fi
          popd
        '';
        ".ssh/config".text = ''
          # ~/.jupyter/jupyter_notebook_config.py; (password in ~/.jupyter/jupyter_server_config.json)
          Host jupyter
            Hostname snubayes.duckdns.org
            User sepiabrown
            Port 7777
            LocalForward 3333 localhost:3333
          # ~/.config/code-server/config.yaml
          Host code-server
            Hostname snubayes.duckdns.org
            User sepiabrown
            Port 7777
            LocalForward 4444 localhost:4444
            LocalForward 4445 localhost:4445
          Host rstudio-server
            Hostname snubayes.duckdns.org
            User sepiabrown
            Port 7777
            LocalForward 5555 localhost:5555
          # config.yml in same directory with ./polynote.py
          # config.yml doesn't work
          Host polynote
            Hostname snubayes.duckdns.org
            User sepiabrown
            Port 7777
            LocalForward 8192 localhost:8192
          Host *
            AddKeysToAgent yes
            IgnoreUnknown UseKeychain
            UseKeychain yes
            IdentityFile ~/.ssh/id_ed25519
        '';
        "filter-file-upload".text = ''
          - ltximg/**
          - Notability/**
        '';
        "filter-file-download".text = ''
          - ltximg/**
        '';
        #".config/gh/hosts.yml".text = ''
        #  github.com:
        #      user: sepiabrown
        #      oauth_token: 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
        #      git_protocol: ssh
        #'';
        #".config/nix/nix.conf".text = builtins.readFile ./nix.conf;
        ".kaggle/kaggle.json".text = ''
          {"username":"suwonpark","key":"ffd3b06e5b9b6b853dc64b736a430f73"}
        '';
        #".zshrc".text = ''
        #eval "''$(direnv hook bash)"
        #'';
        #".direnvrc".text = ''
        #source /run/current-system/sw/share/nix-direnv/direnvrc
        #'';
      };
    }
  ];
}
# TODO 1
# environment = {
#   etc."ipsec.secrets".text = ''
#     include ipsec.d/ipsec.nm-l2tp.secrets
#   '';
#   #variables = {
#   #  TERMINAL = [ "mate-terminal" ];
#   #  # OH_MY_ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
#   #};
# };
# TODO 2
# - emacs overlays
# - nixpkgs.config.permittedInsecurePackages @ configuration_basic.nix
# - mate + xmonad
# - xmobar
# - dmenu
# - virtualbox
# - rstudio
# - texlive
# - dev tools
# - samba
# - samba4Full
# - hplip
# - nvramtool
# - networkmanager
# - networkmanagerapplet

# How to set up tailscale:
# https://www.reddit.com/r/NixOS/comments/olou0x/using_vpn_on_nixos/h5hhrfp/
# 1. Go to Tailscale.com and create an account.
# 2. Add tailscale to /etc/nixos/configuration.nix:
# 3. Add tailscale to environment.systemPackages = with pkgs; [ … ]
# 4. Add services.tailscale.enable = true;
# 5. nixos rebuild !
# 6. Open a new terminal window, run tailscale up. It will give you an authentication link, copy-paste it to a web browser to authenticate that computer.
# 7. check running by systemctl is-active tailscaled
# 8 Tailscale is now active. If you’re running Gnome you can install an extension [1] [2] that gives a visual tray indicator if it’s up.
