{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Desktop-specific packages
  home.packages = with pkgs; [
    telegram-desktop
    portablemc
    rclone
    tmux
    gcc
    rustup
    gh
    stylua
    lua-language-server
  ];
}
