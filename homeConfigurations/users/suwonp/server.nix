{ inputs, ... }:
{
  imports = [
    ./user-specific.nix
    ../../kinds/server.nix
  ];
}
