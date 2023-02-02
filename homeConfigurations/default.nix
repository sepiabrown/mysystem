inputs:
let

  inherit (inputs) nixpkgs home-manager;
  inherit (home-manager.lib) homeManagerConfiguration;

in
{

  "jj@lima" = homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    extraSpecialArgs = { inherit inputs; };
    modules = [ ./jj/lima.nix ];
  };

  "jj@urubamba" = homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    extraSpecialArgs = { inherit inputs; };
    modules = [ ./jj/urubamba.nix ];
  };

  "jj@lapaz" = homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    extraSpecialArgs = { inherit inputs; };
    modules = [ ./jj/lapaz.nix ];
  };

  "jj@bogota" = homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    extraSpecialArgs = { inherit inputs; };
    modules = [ ./jj/bogota.nix ];
  };

  "jj@antofagasta" = homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    extraSpecialArgs = { inherit inputs; };
    modules = [ ./jj/antofagasta.nix ];
  };

  "jj@server" = homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    extraSpecialArgs = { inherit inputs; };
    modules = [ ./jj/kinds/server.nix ];
  };

}
