{ config, pkgs, lib, ... }:

let
  tomlFormat = pkgs.formats.toml { };

  noctaliaSettings = {
    config_version = 14;

    accessibility = {
      ui_scale = 1.25;
    };

    audio = {
      enable_sounds = false;
    };

    bar = {
      order = [ "left" ];
      left = {
        capsule = true;
        capsule_padding = 15.0;
        capsule_radius = 0;
        capsule_thickness = 0.78;
        start = [ "control-center" "clipboard" "clock" ];
        center = [ "workspaces" ];
        end = [ "bluetooth" "network" "session" ];
        font_scale = 1.20;
        font_weight = 1000;
        layer = "top";
        margin_ends = 0;
        padding = 6;
        panel_overlap = 0;
        position = "left";
        radius = 0;
        reserve_space = true;
        scale = 1.5;
        thickness = 53;
        dead_zone.actions.right = "none";
      };
    };

    control_center = {
      hidden_tabs = [ "monitor" "power" "calendar" "notifications" ];
      show_session_button = false;
      show_shortcut_labels = false;
      calendar.show_events_card = false;
      shortcuts = [
        { type = "wifi"; }
        { type = "bluetooth"; }
        { type = "caffeine"; }
        { type = "session"; }
        { type = "clipboard"; }
      ];
    };

    desktop_widgets = {
      schema_version = 2;
      widget_order = [ "audio" ];
      grid = {
        cell_size = 8;
        major_interval = 4;
        visible = true;
      };
      widget.audio = {
        box_height = 550.0;
        box_width = 2560.0;
        cx = 1280.0;
        cy = 1164.0;
        output = "HDMI-A-1";
        placement_height = 1440.0;
        placement_width = 2560.0;
        rotation = 0.0;
        type = "audio_visualizer";
        settings = {
          background = false;
          bands = 52;
          centered = false;
          color_1 = "on_primary";
          color_2 = "on_primary";
          mirrored = true;
          reversed = true;
          show_when_idle = false;
        };
      };
    };

    location = {
      address = "Eitorf, Germany";
    };

    notification = {
      background_opacity = 1.0;
      layer = "overlay";
    };

    osd = {
      background_opacity = 1.0;
      offset_y = 100;
      position = "bottom_center";
    };

    shell = {
      app_icon_color = "primary";
      corner_radius_scale = 0.0;
      font_family = "JetBrains Mono ExtraBold";
      niri_overview_type_to_launch_enabled = true;
      popup_shadows = false;
      screen_time_enabled = true;

      keyboard_layout.custom_labels = {
        "English (US)" = "en";
        Russian = "ru";
      };

      launcher = {
        categories = false;
        fetch_exchange_rates = false;
        show_icons = false;
        sort_by_usage = false;
      };

      panel = {
        control_center_position = "center";
        open_near_click_clipboard = true;
        open_near_click_control_center = true;
        open_near_click_session = true;
        session_placement = "floating";
        session_position = "center";
        wallpaper_position = "center";
      };

      screenshot = {
        annotate = true;
        save_to_file = false;
        show_cursor = true;
      };

      session = {
        show_shortcuts = false;
        actions = [
          {
            action = "reboot";
            countdown_seconds = 0.0;
            enabled = true;
            shortcut = "4";
            variant = "default";
          }
          {
            action = "shutdown";
            countdown_seconds = 0.0;
            enabled = true;
            shortcut = "5";
            variant = "primary";
          }
          {
            action = "logout";
            countdown_seconds = 0.0;
            enabled = true;
            shortcut = "2";
            variant = "default";
          }
        ];
      };

      shadow.alpha = 0.0;
    };

    theme = {
      custom_palette = "stylix";
      mode = "dark";
      source = "custom";
    };

    wallpaper.default = {
      path = "color:${config.lib.stylix.colors.withHashtag.base00}";
    };

    widget = {
      clock = {
        color = "primary";
        actions.left = "none";
      };
      control-center = {
        glyph = "home";
        icon_color = "primary";
      };
      network.show_label = false;
      session.color = "primary";
      workspaces = {
        active_pill_size = 2.0;
        empty_color = "on_secondary";
        occupied_color = "on_secondary";
        show_labels = false;
        urgent_color = "on_secondary";
      };
    };
  };

  settingsFile =
    let
      rawConfig = tomlFormat.generate "settings.toml" noctaliaSettings;
    in
      pkgs.runCommand "noctalia-settings.toml" { } ''
        ${lib.getExe pkgs.noctalia} config validate ${rawConfig}
        cp ${rawConfig} $out
      '';
in
{
  options.modules.noctalia = {
    enable = lib.mkEnableOption "Noctalia desktop shell";
  };

  config = lib.mkIf config.modules.noctalia.enable {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      customPalettes.stylix.dark = {
        mPrimary = lib.mkForce config.lib.stylix.colors.withHashtag.base09;
        mHover = lib.mkForce config.lib.stylix.colors.withHashtag.base09;
      };
    };

    xdg.stateFile."noctalia/settings.toml".source = settingsFile;
  };
}
