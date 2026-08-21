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
  };
  home.file.".local/share/fonts/GoogleSansFlex.ttf".source = ./dots/fonts/GoogleSansFlex.ttf;
  home.file."Pictures/Wallpapers" = {
    source = ./dots/wallpapers;
    recursive = true;
  };
  programs.zsh.completionInit = ''
    fpath+=(${config.home.homeDirectory}/.zsh/completions)
    autoload -U compinit && compinit
  '';

  programs.home-manager.enable = true;
}
