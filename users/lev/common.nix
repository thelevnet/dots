{ pkgs, lib, ... }:

{
  home.username = lib.mkDefault "lev";
  home.homeDirectory = lib.mkDefault "/home/lev";
  home.stateVersion = "26.05";

  imports = [
    ../../modules/home
  ];

  modules = {
    niri.enable = lib.mkDefault true;
    noctalia.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault true;
    fastfetch.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    obsidian.enable = lib.mkDefault true;
    helix.enable = lib.mkDefault true;
    zen.enable = lib.mkDefault true;
    superfile.enable = lib.mkDefault true;
  };

  home.packages = with pkgs; [
    antigravity-cli
    rgit
    gh
    bat
    eza
    zen-browser
    telegram-desktop
    bibata-cursors
  ];
}

