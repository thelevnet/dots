{ ... }:

{
  imports = [
    ./desktop/hyprland.nix
    ./desktop/noctalia.nix
    ./editors/neovim.nix
    ./terminal/fastfetch.nix
    ./terminal/kitty.nix
    ./terminal/starship.nix
    ./terminal/zsh.nix
    ./theme
  ];
}
