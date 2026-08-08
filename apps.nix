{ config, pkgs, inputs, ...}:
{
environment.systemPackages = with pkgs; [
    #next start
		fzf
		btop
    portablemc
	  nh
    rustup
    wget
    git
    bat
    nasm
    fastfetch
    eza
    kdePackages.filelight
    kitty
    yazi
    ripgrep
    google-chrome
    telegram-desktop
    neovim
    #dependencies
    stylua
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    brightnessctl
    nerd-fonts.jetbrains-mono
    bibata-cursors
    lua-language-server
    qrencode
    #next end
  ];
}

