 { config, pkgs, inputs, ... }:

{
  home.username = "lev";
  home.homeDirectory = "/home/lev";
  home.stateVersion = "26.05";

  xdg.configFile = {
    "hypr".source = ./dots/hypr;
    "kitty".source = ./dots/kitty;
    "nvim".source = ./dots/nvim;
    "fastfetch".source = ./dots/fastfetch;
    "noctalia".source = ./dots/noctalia;
    "mimeapps.list".source = ./dots/mimeapps.list;
    "chrome-flags.conf".source = ./dots/chrome-flags.conf;
  };
  home.file.".local/share/fonts/GoogleSansFlex.ttf".source = ./dots/fonts/GoogleSansFlex.ttf;
  home.file."Pictures/Wallpapers" = {
    source = ./dots/wallpapers;
    recursive = true;
  };

  programs.home-manager.enable = true;
}
