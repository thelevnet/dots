{ inputs, ... }:

{
  imports = [
    inputs.nite.homeManagerModules.nite
    ./fastfetch.nix
    ./kitty.nix
    ./niri.nix
    ./nite.nix
    ./noctalia.nix
    ./starship.nix
    ./zsh.nix
    ./obsidian.nix
    ../../pkgs/hm
    ./helix.nix
    ./zen
  ];
}
