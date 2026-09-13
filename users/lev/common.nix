{ pkgs, lib, ... }:

{
  home.username = lib.mkDefault "lev";
  home.homeDirectory = lib.mkDefault "/home/lev";
  home.stateVersion = "26.05";

  imports = [
    ../../modules/home
  ];

  # Enabled user modules
  modules = {
    gui.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    noctalia.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault true;
    fastfetch.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
    theme.enable = lib.mkDefault true;
  };

  # Common CLI tools
  home.packages = with pkgs; [
    antigravity-cli
    zoxide
    fetch
    gh
    git
    bat
    eza
    yazi
    qrencode
  ];

  programs.home-manager.enable = true;
}
