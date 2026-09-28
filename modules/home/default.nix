{ inputs, ... }:

{
  imports = [
    inputs.nite.homeManagerModules.nite
    ./fastfetch.nix
    ./kitty.nix
    ./neovim.nix
    ./niri.nix
    ./nite.nix
    ./noctalia.nix
    ./starship.nix
    ./theme.nix
    ./zsh.nix
  ];
}
