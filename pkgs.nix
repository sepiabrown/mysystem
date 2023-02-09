{ inputs ?
  let flake = builtins.getFlake (toString ./.);
  in flake.inputs
, system ? builtins.currentSystem
, overlays ? []
}:
let
  inherit (inputs) nixpkgs deploy-rs agenix kmonad;
in
import nixpkgs {
  inherit system;
  overlays = [
    deploy-rs.overlay
    agenix.overlays.default
    (final: prve: {
      xmonad-restart = inputs.myxmonad.packages.${system}.xmonad-restart;
      kmonad = inputs.kmonad.packages.${system}.kmonad;
    })
  ] ++ overlays;
}
