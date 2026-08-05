{ config, pkgs, inputs, ...}:
{
environment.systemPackages = with pkgs; [
    #next start
		qrencode
		fzf
		btop
    portablemc
	  nh
    fd
    vlc
    rustup
    discord
    gcc
    lua-language-server
    stylua
    unzip
    wget
    git
    bat
    nasm
    fastfetch
    eza
    kdePackages.filelight
    kitty
    bibata-cursors
    nerd-fonts.jetbrains-mono
    kdePackages.dolphin
    cmake
    ripgrep
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    brightnessctl
    google-chrome
    telegram-desktop
    neovim
    #next end
  ];
}

