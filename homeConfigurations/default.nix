inputs:
let

  inherit (inputs) nixpkgs home-manager;
  inherit (home-manager.lib) homeManagerConfiguration;
  inherit (pkgs.lib) elemAt splitString;

  pkgs = nixpkgs.legacyPackages."x86_64-linux";

  getUserHostname = str: let
    list = splitString "@" str;
  in {
    user = elemAt list 0;
    hostname = elemAt list 1;
  };

  homeManagerConfigurations = __listToAttrs (map (name: let
    inherit (getUserHostname name) user hostname;
  in {
    inherit name;
    value = homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [ ./users/${user}/${hostname}.nix ];
    };
  }) [ "jj@urubamba"
       "jj@lima"
       "jj@lapaz"
       "jj@bogota"
       "jj@antofagasta"
       "jj@server"
       "jiwon@havana"
       "suwonp@urubamba"
     ]);

in homeManagerConfigurations
# {

#   "jj@lima" = homeManagerConfiguration {
#     pkgs = nixpkgs.legacyPackages."x86_64-linux";
#     extraSpecialArgs = { inherit inputs; };
#     modules = [ ./users/jj/lima.nix ];
#   };

#   "jj@urubamba" = homeManagerConfiguration {
#     pkgs = nixpkgs.legacyPackages."x86_64-linux";
#     extraSpecialArgs = { inherit inputs; };
#     modules = [ ./users/jj/urubamba.nix ];
#   };

#   "jj@lapaz" = homeManagerConfiguration {
#     pkgs = nixpkgs.legacyPackages."x86_64-linux";
#     extraSpecialArgs = { inherit inputs; };
#     modules = [ ./users/jj/lapaz.nix ];
#   };

#   "jj@bogota" = homeManagerConfiguration {
#     pkgs = nixpkgs.legacyPackages."x86_64-linux";
#     extraSpecialArgs = { inherit inputs; };
#     modules = [ ./users/jj/bogota.nix ];
#   };

#   "jj@antofagasta" = homeManagerConfiguration {
#     pkgs = nixpkgs.legacyPackages."x86_64-linux";
#     extraSpecialArgs = { inherit inputs; };
#     modules = [ ./users/jj/antofagasta.nix ];
#   };

#   "jj@server" = homeManagerConfiguration {
#     pkgs = nixpkgs.legacyPackages."x86_64-linux";
#     extraSpecialArgs = { inherit inputs; };
#     modules = [ ./users/jj/server.nix ];
#   };

#   "jiwon@havana" = homeManagerConfiguration {
#     pkgs = nixpkgs.legacyPackages."x86_64-linux";
#     extraSpecialArgs = { inherit inputs; };
#     modules = [ ./users/jiwon/havana.nix ];
#   };

#   "suwonp@urubamba" = homeManagerConfiguration {
#     pkgs = nixpkgs.legacyPackages."x86_64-linux";
#     extraSpecialArgs = { inherit inputs; };
#     modules = [ ./users/suwonp/urubamba.nix ];
#   };
# }
