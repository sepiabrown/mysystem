{ pkgs ? import ./pkgs.nix {} }: with pkgs;

mkShell {
  buildInputs = [ mynitrogen ];
}
