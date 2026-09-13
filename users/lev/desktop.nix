{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  home.packages = with pkgs; [
    rclone
    tmux
    gcc
    rustup
    stylua
    lua-language-server
  ];
}
