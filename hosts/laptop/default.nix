{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./hardware.nix
    ../common
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/tailscale.nix
  ];

  networking.hostName = "laptop";

  # Boot loader & kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "i2c-dev" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Hardware features
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
