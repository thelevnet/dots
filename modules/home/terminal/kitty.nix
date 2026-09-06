{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14.0;
    };

    shellIntegration = {
      mode = "no-cursor";
    };

    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      hide_window_decorations = "yes";
      background_opacity = "1";
      background_blur = 20;
      confirm_os_window_close = 0;
      window_padding_width = 5;

      cursor_shape = "block";
      cursor_blink_interval = 0;
      cursor_trail = 3;

      "include" = "~/.cache/noctalia/kitty-theme.conf";
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
    };
  };
}
