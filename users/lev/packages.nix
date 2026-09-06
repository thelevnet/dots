{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dust
    antigravity-cli
    zen-browser
    libnotify
    fetch
    next
    jq
    gcc
    fzf
    portablemc
    nh
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
