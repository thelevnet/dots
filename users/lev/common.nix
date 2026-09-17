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
    neovim.enable = lib.mkDefault true;
    theme.enable = lib.mkDefault true;
  };

  home.packages = with pkgs; [
    # CLI & tools
    antigravity-cli
    gh
    bat
    eza
    yazi

    # GUI & workstation
    zen-browser
    telegram-desktop
    portablemc
    bibata-cursors
  ];

  programs.home-manager.enable = true;
}

