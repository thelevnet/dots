{ config, lib, ... }:

{
  options.modules.kitty = {
    enable = lib.mkEnableOption "Kitty terminal emulator";
  };

  config = lib.mkIf config.modules.kitty.enable {
    programs.kitty = {
      enable = true;

      shellIntegration = {
        mode = "no-cursor";
      };

      settings = {
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";

        confirm_os_window_close = 0;
        window_padding_width = 5;

        cursor_shape = "block";
        cursor_blink_interval = 0;
        cursor_trail = 3;
        cursor = "#ef934d";
        cursor_trail_color = "#ef934d";

        allow_remote_control = "socket-only";
        listen_on = "unix:@mykitty";
      };

      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
        "ctrl+v" = "paste_from_clipboard";
      };
    };
  };
}
