{ config, pkgs, lib, ... }:

{
  options.modules.niri = {
    enable = lib.mkEnableOption "Niri scrollable-tiling Wayland compositor and graphics";
  };

  config = lib.mkIf config.modules.niri.enable {
    programs.niri = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
