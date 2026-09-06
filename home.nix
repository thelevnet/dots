{ config, pkgs, inputs, ... }:

{
  home.username = "lev";
  home.homeDirectory = "/home/lev";
  home.stateVersion = "26.05";
  imports = [
    ./modules/hyprland.nix
    ./modules/kitty.nix
    ./modules/fastfetch.nix
    ./modules/noctalia.nix
    ./modules/neovim.nix
    ./modules/theme-assets.nix
  ];

  programs.home-manager.enable = true;
}
