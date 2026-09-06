{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./hardware.nix
    ../common
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/minecraft.nix
    ../../modules/nixos/tailscale.nix
  ];

  networking.hostName = "nix";

  # Boot loader & kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.kernelModules = [ "i2c-dev" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Hardware features
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
