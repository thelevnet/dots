{ config, pkgs, inputs, lib, ... }:

{
  home.username = "lev";
  home.homeDirectory = "/home/lev";
  home.stateVersion = "26.05";

  imports = [
    ../../modules/home
  ];

  modules = {
    hyprland.enable = lib.mkDefault true;
    noctalia.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault true;
    fastfetch.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
    theme.enable = lib.mkDefault true;
  };

  home.packages = with pkgs; [
    antigravity-cli
    zen-browser
    zoxide
    fetch
    gh
    portablemc
    git
    telegram-desktop
    bat
    eza
    yazi
    bibata-cursors
    qrencode
  ];

  programs.home-manager.enable = true;
}
