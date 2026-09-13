{ config, lib, ... }:

{
  options.modules.theme = {
    enable = lib.mkEnableOption "Desktop theme and assets";
  };

  config = lib.mkIf config.modules.theme.enable {
    home.file.".local/share/fonts/GoogleSansFlex.ttf".source = ../../assets/fonts/GoogleSansFlex.ttf;
    home.file."Pictures" = {
      source = ../../assets/wallpapers;
      recursive = true;
    };
  };
}
