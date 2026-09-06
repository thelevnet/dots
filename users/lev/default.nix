{ config, pkgs, inputs, ... }:

{
  home.username = "lev";
  home.homeDirectory = "/home/lev";
  home.stateVersion = "26.05";

  imports = [
    ./packages.nix
    ../../modules/home/desktop/hyprland.nix
    ../../modules/home/desktop/noctalia.nix
    ../../modules/home/terminal/kitty.nix
    ../../modules/home/terminal/fastfetch.nix
    ../../modules/home/terminal/zsh.nix
    ../../modules/home/editors/neovim.nix
    ../../modules/home/theme
  ];

  programs.home-manager.enable = true;
}
