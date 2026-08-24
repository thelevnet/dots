{ config, pkgs, inputs, ...}:
{
environment.systemPackages = with pkgs; [
    #next start
		opencode
		antigravity-cli
    inputs.zen-browser.packages.${pkgs.system}.default
		libnotify
		fetch
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
    (llama-cpp.override { vulkanSupport = true; })
    python3
    aria2
    #next end
  ];
}

