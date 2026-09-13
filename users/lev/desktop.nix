{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Desktop-specific packages
  home.packages = with pkgs; [
    zen-browser
    telegram-desktop
    portablemc
  ];
}
