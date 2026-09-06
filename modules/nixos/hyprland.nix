{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
