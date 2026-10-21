{ config, pkgs, lib, ... }:

{
  options.modules.stylix = {
    enable = lib.mkEnableOption "Stylix system-wide styling and color theme";
  };

  config = lib.mkIf config.modules.stylix.enable {
    stylix = {
      enable = true;
      polarity = "dark";
      image = config.lib.stylix.pixel "base00";

      base16Scheme = {
        base00 = "0f0f0f";
        base01 = "1e1f1e";
        base02 = "272a28";
        base03 = "3b403c";
        base04 = "9a9c8b";
        base05 = "f4decd";
        base06 = "e3d6c9";
        base07 = "faf5f0";
        base08 = "f16e65";
        base09 = "ef934d";
        base0A = "efbf71";
        base0B = "7ec97e";
        base0C = "7ec9a3";
        base0D = "71b4d6";
        base0E = "e28dc6";
        base0F = "ef968f";
      };

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };

        sizes = {
          terminal = 20;
        };
      };

      targets.qt.enable = false;
    };

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "xdgdesktopportal";
    };
  };
}
