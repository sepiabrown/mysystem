{ inputs, ... }:
{
  imports = [
    ./user-specific.nix
    ../../kinds/laptop.nix
  ];
}
