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

    # Development tools
    antigravity-cli
    gcc
    rustup
    gh
    stylua
    lua-language-server
  ];
}
