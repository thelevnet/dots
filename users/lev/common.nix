{ pkgs, lib, ... }:

{
  home.username = lib.mkDefault "lev";
  home.homeDirectory = lib.mkDefault "/home/lev";
  home.stateVersion = "26.05";

  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    antigravity-cli
    git
    gh
    bat
    eza
    yazi
  ];

  programs.home-manager.enable = true;
}
