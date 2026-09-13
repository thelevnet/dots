{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Desktop-specific packages
  home.packages = with pkgs; [
    rclone
    tmux
    gcc
    rustup
    stylua
    lua-language-server
  ];
}
