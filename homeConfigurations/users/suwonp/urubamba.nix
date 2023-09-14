{ inputs, ... }:
{
  imports = [
    ./user-specific.nix
    ../../kinds/laptop.nix
    ./dotfiles/homemanager_optional.nix
  ];
}
