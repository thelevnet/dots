{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #next start
    dust
    antigravity-cli
    zen-browser
    libnotify
    fetch
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
    #next end
  ];
}
