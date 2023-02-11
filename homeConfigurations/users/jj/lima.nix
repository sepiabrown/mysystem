{ inputs, ... }:
{
  imports = [
    ./user-info.nix
    ../../kinds/laptop.nix
  ];
}
