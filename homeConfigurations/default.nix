inputs:
let

  inherit (inputs) nixpkgs home-manager;
  inherit (home-manager.lib) homeManagerConfiguration;
  inherit (pkgs) lib;
  inherit (lib) elemAt splitString;

  pkgs = nixpkgs.legacyPackages."x86_64-linux";

  user-machine-names = __filter lib.isString (
      map
        (path:
          let
            matches = __match ".*/users/(.*).nix" (toString path);
          in
            if lib.isList matches
               && __length matches == 1
               && ! lib.hasSuffix "default" (__head matches)
               && ! lib.hasSuffix "flake" (__head matches)
            then __head matches
            else null)
        (lib.filesystem.listFilesRecursive ./.));

  getUserHostname = str: let
    list = splitString "/" str;
  in {
    user = elemAt list 0;
    hostname = elemAt list 1;
  };

  homeManagerConfigurations = __listToAttrs (map (name: let
    inherit (getUserHostname name) user hostname;
  in {
    name = __replaceStrings ["/"] ["@"] name;
    value = homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [ ./users/${user}/${hostname}.nix ];
    };
  }) user-machine-names);

in homeManagerConfigurations
