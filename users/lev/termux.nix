{ pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  # Termux on Android environment
  home = {
    username = lib.mkDefault "termux";
    homeDirectory = "/data/data/com.termux/files/home";
  };

  # Disable desktop/GUI modules; enable CLI tools
  modules = {
    gui.enable = false;
    hyprland.enable = false;
    noctalia.enable = false;
    kitty.enable = false;
    theme.enable = false;

    zsh.enable = true;
    starship.enable = true;
    neovim.enable = true;
    fastfetch.enable = true;
  };

  # Phone & Termux-specific packages
  home.packages = with pkgs; [
    tmux
    ripgrep
    fd
    fzf
    jq
    next
  ];
}
