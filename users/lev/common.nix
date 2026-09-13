{ pkgs, lib, ... }:

{
  home.username = lib.mkDefault "lev";
  home.homeDirectory = lib.mkDefault "/home/lev";
  home.stateVersion = "26.05";

  imports = [
    ../../modules/home
  ];

  # Base CLI tools common to all devices (desktop, laptop, phone)
  home.packages = with pkgs; [
    antigravity-cli # agy
    git
    gh
    bat
    eza
    yazi
  ];

  programs.home-manager.enable = true;
}
