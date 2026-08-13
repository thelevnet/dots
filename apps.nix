{ config, pkgs, inputs, ...}:
{
environment.systemPackages = with pkgs; [
    #next start
		libnotify
		fetch
		firefox
		next
		btop
		jq
		home-manager
		gcc
		fzf
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
    telegram-desktop
    neovim
    #next dependencies
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

