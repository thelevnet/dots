{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./hardware.nix
    ../common
  ];

  networking.hostName = "desktop";

  # Enabled modules
  modules = {
    hyprland.enable = true;
    minecraft.enable = true;
    tailscale.enable = true;
  };

  # Boot loader & kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.kernelModules = [ "i2c-dev" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Hardware features
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # User profile
  home-manager.users.lev = import ../../users/lev/desktop.nix;
}
