{

  description = "my system configurations using nix";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-20.09";
    flake-utils.url = "github:numtide/flake-utils/master";
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    home-manager = { url = "github:nix-community/home-manager/master"; inputs.nixpkgs.follows = "nixpkgs"; };
    darwin = { url = "github:LnL7/nix-darwin/master"; inputs.nixpkgs.follows = "nixpkgs"; };
    nur.url = "github:nix-community/NUR/master";
    chemacs2 = { url = "github:plexus/chemacs2"; flake = false; };
    nix-doom-emacs.url = "github:wavetojj/nix-doom-emacs";
    jupyter_contrib_core = { url = "github:Jupyter-contrib/jupyter_contrib_core"; flake = false; };
    jupyter_nbextensions_configurator = { url = "github:Jupyter-contrib/jupyter_nbextensions_configurator"; flake = false; };
    nixos-hardware.url = "github:nixos/nixos-hardware";

  };

  outputs =
    inputs@{ self, nixpkgs, darwin, home-manager, flake-compat, flake-utils, nur
           , chemacs2, nix-doom-emacs
           , jupyter_contrib_core, jupyter_nbextensions_configurator
           , ... }:

    let

      lib = nixpkgs.lib;

      nixpkgsConfig = hostname: with inputs; {

        config = {
          allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg)
            [ # whitelist for firefox
              "firefox-beta-bin"
              "firefox-beta-bin-unwrapped"
              "languagetool"
              "lastpass-password-manager"
              "broadcom-sta"
              "cudatoolkit"
              "zoom"
              "google-chrome"
              "anydesk"
              "slack"
              "Oracle_VM_VirtualBox_Extension_Pack"
              "symbola"
            ];
          inherit hostname;
        };

        overlays = self.overlays;
      };


      mkDarwinModules = { user, hostname, home, nixos }: [
        nixos
        home-manager.darwinModules.home-manager
        {
          nixpkgs = nixpkgsConfig hostname;
          users.users.${user}.home = "/Users/${user}";
          home-manager.users.${user} = {
            imports = [ nix-doom-emacs.hmModule
                        home ];
          };

          networking.computerName = user + "-" + hostname;
          networking.hostName = hostname;
          networking.knownNetworkServices = [
            "Wi-Fi"
            "USB 10/100/1000 LAN"
          ];
        }
      ];


      mkNixosModules = { user, hostname, home, nixos }: [
        nixos
        home-manager.nixosModules.home-manager
        {
          nixpkgs = nixpkgsConfig hostname;
          home-manager.users.${user} = {
            imports = [ nix-doom-emacs.hmModule
                        home ];
          };
          networking.hostName = hostname;
        }
      ];

      # This keys for the distributed builds
      root = {
        hashedPassword = "$6$T80JsrUCydok0S$5/CAsrhK77RRPP3QlqAFjOgjp9CEo/0LUUXwkmT9Tjmsz08DfY5.FkLp3SU3EhlLesH2aq7FGVBBEc07s3R7u/";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOxtKP75Zobhn/Jioh9Wp1poDoePTm0suv3vufcRCdP0 root@x1"
        ];
      };

      hosts = {

        x1 = {
          ip = "10.100.0.2";
          wg-ips = [ "10.100.0.2/24" ] ; # to set up the wireguard
          configuration = ./nixos/linux/hosts/x1;
          home = ./home/linux/hosts/x1;
        };

        legion5 = {
          ip = "10.100.0.22";
          wg-ips = [ "10.100.0.22/24" ]; # to set up the wireguard
          configuration = ./nixos/linux/hosts/legion5;
          home = ./home/linux/hosts/legion5;
        };

        l14 = {
          ip = "100.72.169.29";
          wg-ips = [ "10.100.0.4/24" ]; # to set up the wireguard
          configuration = ./nixos/linux/hosts/l14;
          home = ./home/linux/hosts/l14;
        };

        mp = {
          ip = "100.72.169.29";
          wg-ips = [ "10.100.100.2/24" ]; # to set up the wireguard
          configuration = ./nixos/linux/hosts/mp;
          home = ./home/linux/hosts/mp;
        };


      };

      users = {

        # inherit root;

        jj = {
          isNormalUser = true;
          uid = 1000;
          home = "/home/jj";
          extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
          hashedPassword = "$6$3nKguLgJMB$leFSKrvWiUAXiay8MJ8i66.ZzufIhkrrbxzv625DV28xSYGBCLp62pyIp4U3s8miHcOdJZpWLgDMEoWljPtT0.";
          openssh.authorizedKeys.keys = [
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+XEhhqkpyVtUSu+t2JT3j5QxHUGBwCOiOwyc/4Ukpk8F2XP+ac5i9QuFd+yKXeoQcmgke6y+h7HjVBMDYD5OJRq6N4ep9dfU6svGccVNScbh+dOB+WtzrZco7euddOhtjT4pbSoyhImg5AJxA0SgvHnoTTq4nvMYAbCG9xSWz353FV1nrJPLo0bpEOSqdeb3HTgDntcMv9KaNGHe6hzGIPBQvW/y2FQ3hiHtDS+WIBQzPrQnRRslrCr7hcBwniYfKBdgjENK2yLIgDSoTwUXYFTMZgrjBejCo33+bR2Jrk66isEOR7oThHsI7vnxjSlUKmQ4o+B4e1lsILIyW0GPz0s/vrdTfZdqt+eZ38NJhqJD7mDruhuBf1NNE/rNWazu36afSQnRXhv9XgHo1cF1NMtC10grOrA5fUylGRHS8tS2RZHJ9OXgxBcV0bdIbqOu7jFRTzvm36dcMyJrALrz4ZEg/BJ7IOgtd1cTpcvxcQzDZSd+mSPHaY82urSH7QCc= jj@x1"
          ];
        };

      };

      mkNixOSConfiguration = name: host: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [

          ({ pkgs, ... }: {
            users.mutableUsers = false;
            users.extraUsers = users;
          })
          (import ./nixos/linux/wireguard host.wg-ips)
          host.configuration
          home-manager.nixosModules.home-manager
          {
            nixpkgs = {
              config = {
                allowUnfree = true;
                hostName = name;
              };
              overlays = [ self.overlay ];
            };
            home-manager.users =
              (nixpkgs.lib.mapAttrs (username: user:
                {  imports = [ nix-doom-emacs.hmModule
                               host.home
                            ];
                }
              ) users);
          }
        ];
      };

    in rec {

      overlays = [
        nur.overlay
        nix-doom-emacs.overlay
        (import ./packages/myemacs/overlay.nix)
        (import ./packages/myvim/overlay.nix)
        (import ./packages/myfonts/overlay.nix)
        (import ./packages/mylockscreen/overlay.nix)
        (import ./packages/mywallpapers-1366/overlay.nix)
        (import ./packages/mynitrogen/overlay.nix)
        (import ./packages/myflow/overlay.nix)
        (import ./packages/myplot/overlay.nix)
        (import ./packages/myhaskell/overlay.nix)
        (import ./packages/mypython/overlay.nix)
        (import ./packages/myjupyter/overlay.nix)
        (import ./packages/myjupyter/jupyter-overlay.nix {
          inherit
            jupyter_contrib_core
            jupyter_nbextensions_configurator; })
        (import ./overlay.nix { inherit inputs mkNixOSConfiguration hosts; })
      ];

      overlay = nixpkgs.lib.composeManyExtensions self.overlays;


      #--------------------------------------------------------------------------
      #
      #  Darwin Configurations
      #
      #  How to run:
      #   1. Build darwin-rebuild for this flake first
      #     > nix build .#darwinConfigurations.mbp15.system
      #   2. Then use ./result/sw/bin/darwin-rebuild to switch
      #     > ./result/sw/bin/darwin-rebuild switch --flake .#mbp15
      #
      #  Or change mbp15 to one of other darwin configurations
      #
      #--------------------------------------------------------------------------

      darwinConfigurations = {

        mbp15 = darwin.lib.darwinSystem {
          modules = mkDarwinModules {
            user     = "jj";
            hostname = "mbp15";
            nixos    = ./nixos/darwin/hosts/mbp15;
            home     = ./home/darwin/hosts/mbp15;
          };

        };

      };

      nixosConfigurations = (nixpkgs.lib.mapAttrs mkNixOSConfiguration hosts);

      nixosPackages = (nixpkgs.lib.mapAttrs
        (name: host: host.config.system.build.toplevel)
        self.nixosConfigurations);

  } // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config = {};
        overlays = [ self.overlay ];
      };

    in rec {
      devShell = import ./develop.nix { inherit pkgs; };

      defaultPackage = pkgs.deploy;
      packages = {
        deploy = pkgs.deploy;
      } // self.nixosPackages;

      defaultApp = apps.deploy;
      apps = {
        # add other apps here
      } // pkgs.nixOSApps;
    }

  );
}
