{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../common
  ];

  networking.hostName = "desktop";

  # Desktop-specific modules
  modules.minecraft.enable = true;

  # Desktop-specific bootloader & kernel
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Desktop user profile
  home-manager.users.lev = import ../../users/lev/desktop.nix;
}
