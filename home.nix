{ config, pkgs, inputs, ... }:

{
  home.username = "lev";
  home.homeDirectory = "/home/lev";
  home.stateVersion = "26.05";
  imports = [
    ./modules/hyprland.nix
    ./modules/kitty.nix
    ./modules/fastfetch.nix
  ];

  xdg.configFile = {
    "nvim".source = ./dots/nvim;
    "noctalia".source = ./dots/noctalia;
  };

  home.file.".local/share/fonts/GoogleSansFlex.ttf".source = ./dots/fonts/GoogleSansFlex.ttf;
  home.file."Pictures/" = {
    source = ./dots/wallpapers;
    recursive = true;
  };

  programs.home-manager.enable = true;
}
