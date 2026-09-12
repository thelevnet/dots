{ pkgs, ... }:

{
  home.packages = with pkgs; [
    antigravity-cli
    zoxide
    zen-browser
    libnotify
    fetch
    gcc
    portablemc
    rustup
    git
    gh
    rclone
    bat
    eza
    yazi
    telegram-desktop
    tmux
    stylua
    bibata-cursors
    lua-language-server
    qrencode
  ];
}
