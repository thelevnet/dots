{ config, pkgs, lib, ... }:

{
  options.modules.gui = {
    enable = lib.mkEnableOption "Desktop GUI applications";
  };

  config = lib.mkIf config.modules.gui.enable {
    home.packages = with pkgs; [
      zen-browser
      telegram-desktop
      bibata-cursors
      portablemc
    ];
  };
}
