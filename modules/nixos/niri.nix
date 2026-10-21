{ config, lib, ... }:

{
  options.modules.niri = {
    enable = lib.mkEnableOption "Niri scrollable-tiling Wayland compositor and graphics";
  };

  config = lib.mkIf config.modules.niri.enable {
    programs.niri.enable = true;
  };
}
