{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  options.modules.hyprland = {
    enable = lib.mkEnableOption "Hyprland compositor and graphics";
  };

  config = lib.mkIf config.modules.hyprland.enable {
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
  };
}
