{ config, pkgs, lib, ... }:

{
  home.file.".local/share/fonts/GoogleSansFlex.ttf".source = ../../../assets/fonts/GoogleSansFlex.ttf;
  home.file."Pictures" = {
    source = ../../../assets/wallpapers;
    recursive = true;
  };
}
