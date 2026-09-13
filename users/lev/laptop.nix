{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Laptop-specific packages
  home.packages = with pkgs; [
    brightnessctl
  ];
}
