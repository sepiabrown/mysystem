{ inputs, pkgs, ... }:
let

  pkgs' = pkgs.extend (final: prev: {

    haskell = let
      packageOverrides = pkgs.lib.composeManyExtensions [
        (pkgs.haskell.packageOverrides or (_: _: {}))
        (hfinal: hprev: let
          inherit (pkgs.haskell.lib) doJailbreak markUnbroken overrideCabal;
          in
          {
            giter = (hfinal.callCabal2nix "giter" inputs.giter {}).overrideAttrs (drv:
            { preConfigure = (drv.preConfigure or "") + ''
                touch LICENSE
              '';
            });

          })
    ];
    in prev.haskell // { inherit packageOverrides; };

  });



in
{

  home.packages =  [
    pkgs'.haskell.packages.ghc924.giter
  ];
}
