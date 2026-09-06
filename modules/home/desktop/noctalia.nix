{ config, pkgs, lib, ... }:

{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    checkConfig = true;

    settings = {
      accessibility = {
        high_contrast = false;
        ui_scale = 1.0;
      };
      audio = {
        enable_overdrive = false;
        enable_sounds = true;
        notification_sound = "";
        sound_volume = 0.5;
        volume_change_sound = "";
      };
      backdrop = {
        blur_intensity = 0.5;
        enabled = false;
        tint_intensity = 0.30000001192092896;
      };
      bar = {
        left = {
          auto_hide = false;
          background_opacity = 1.0;
          border = "outline";
          border_width = 0.0;
          capsule = true;
          capsule_fill = "surface_variant";
          capsule_group = [ ];
          capsule_opacity = 1.0;
          capsule_padding = 14.0;
          capsule_thickness = 0.7599999904632568;
          center = [
            "clock"
          ];
          concave_edge_corners = true;
          contact_shadow = false;
          dead_zone = {
            actions = {
              right = "none";
            };
          };
          enabled = true;
          end = [
            "todo"
            "notes"
          ];
          font_scale = 1.0;
          font_weight = 900;
          hover_highlight = true;
          layer = "top";
          margin_edge = 0;
          margin_ends = 0;
          margin_opposite_edge = 0;
          padding = 10;
          panel_overlap = 0;
          position = "left";
          radius = 30;
          radius_bottom_left = 0;
          radius_bottom_right = 30;
          radius_top_left = 0;
          radius_top_right = 30;
          reserve_space = true;
          scale = 1.0;
          shadow = true;
          show_on_workspace_switch = true;
          smart_auto_hide = false;
          start = [
            "power_profile"
            "volume"
          ];
          thickness = 58;
          widget_spacing = 6;
        };
        order = [
          "left"
          "right"
        ];
        right = {
          auto_hide = false;
          background_opacity = 1.0;
          border = "outline";
          border_width = 0.0;
          capsule = true;
          capsule_fill = "surface_variant";
          capsule_group = [ ];
          capsule_opacity = 1.0;
          capsule_padding = 14.0;
          capsule_thickness = 0.7599999904632568;
          center = [
            "workspaces"
          ];
          concave_edge_corners = true;
          contact_shadow = false;
          dead_zone = {
            actions = {
              right = "none";
            };
          };
          enabled = true;
          end = [
            "clipboard"
            "session"
          ];
          font_scale = 1.0;
          font_weight = 900;
          hover_highlight = true;
          layer = "top";
          margin_edge = 0;
          margin_ends = 0;
          margin_opposite_edge = 0;
          padding = 10;
          panel_overlap = 0;
          position = "right";
          radius = 30;
          radius_bottom_left = 30;
          radius_bottom_right = 0;
          radius_top_left = 30;
          radius_top_right = 0;
          reserve_space = true;
          scale = 1.0;
          shadow = true;
          show_on_workspace_switch = true;
          smart_auto_hide = false;
          start = [
            "screenshot"
            "widget"
          ];
          thickness = 58;
          widget_spacing = 6;
        };
      };
      battery = {
        warning_threshold = 10;
      };
      brightness = {
        enable_ddcutil = false;
        ignore_mmids = [ ];
        minimum_brightness = 0.0;
        sync_all_monitors = false;
      };
      calendar = {
        account = {
          google_account = {
            calendars = [ ];
            color = "primary";
            credential_source = "secret-service";
            name = "Google";
            password_file = "";
            provider = "";
            server_url = "";
            type = "google";
            username = "";
          };
        };
        enabled = true;
        refresh_minutes = 15;
      };
      control_center = {
        calendar = {
          event_date_format = "%A %e %B";
          event_time_format = "%H:%M";
          show_events_card = false;
          show_week_numbers = true;
        };
        hidden_tabs = [ ];
        shortcuts = [
          {
            type = "wifi";
          }
          {
            type = "bluetooth";
          }
          {
            type = "caffeine";
          }
          {
            type = "power_profile";
          }
          {
            type = "system";
          }
          {
            type = "keyboard_layout";
          }
        ];
        show_session_button = true;
        show_shortcut_labels = false;
        sidebar = "compact";
        sidebar_section = "compact";
        width = 720;
      };
      desktop_widgets = {
        enabled = true;
        grid = {
          cell_size = 32;
          major_interval = 4;
          visible = true;
        };
        schema_version = 2;
        widget = {
          desktop-widget-000000000000000a = {
            box_height = 288.0;
            box_width = 1792.0;
            cx = 960.0;
            cy = 928.5;
            enabled = true;
            output = "eDP-1";
            placement_height = 0.0;
            placement_width = 0.0;
            rotation = 0.0;
            settings = {
              background = false;
              bands = 24;
              centered = false;
              color_1 = "primary";
              color_2 = "primary";
              mirrored = true;
              show_when_idle = false;
            };
            type = "audio_visualizer";
          };
          desktop-widget-000000000000000b = {
            box_height = 704.0;
            box_width = 2432.0;
            cx = 1282.0;
            cy = 1078.0;
            enabled = true;
            output = "DP-1";
            placement_height = 1440.0;
            placement_width = 2560.0;
            rotation = 0.0;
            settings = {
              background = false;
              bands = 52;
              centered = false;
              color_1 = "primary";
              mirrored = true;
              show_when_idle = false;
            };
            type = "audio_visualizer";
          };
        };
        widget_order = [
          "desktop-widget-000000000000000a"
          "desktop-widget-000000000000000b"
        ];
      };
      dock = {
        active_monitor_only = false;
        active_opacity = 1.0;
        active_scale = 1.0;
        auto_hide = true;
        background_opacity = 1.0;
        border = "primary";
        border_width = 3.0;
        concave_edge_corners = true;
        cross_axis_padding = 8;
        enabled = true;
        icon_size = 48;
        inactive_opacity = 1.0;
        inactive_scale = 1.0;
        item_spacing = 6;
        launcher_custom_image = "";
        launcher_custom_image_colorize = false;
        launcher_icon = "grid-dots";
        launcher_position = "none";
        layer = "top";
        magnification = true;
        magnification_scale = 2.0;
        main_axis_padding = 57;
        margin_edge = 16;
        margin_ends = 0;
        monitors = [ ];
        pinned = [
          "zen"
          "org.telegram.desktop"
          "kitty"
        ];
        position = "bottom";
        radius = 58;
        radius_bottom_left = 58;
        radius_bottom_right = 58;
        radius_top_left = 58;
        radius_top_right = 58;
        reserve_space = false;
        shadow = true;
        show_dots = true;
        show_instance_count = false;
        show_running = true;
        smart_auto_hide = false;
      };
      hooks = {
        battery_charging = [ ];
        battery_discharging = [ ];
        battery_percentage_changed = [ ];
        battery_plugged = [ ];
        bluetooth_disabled = [ ];
        bluetooth_enabled = [ ];
        colors_changed = [ ];
        logging_out = [ ];
        power_profile_changed = [ ];
        rebooting = [ ];
        session_locked = [ ];
        session_unlocked = [ ];
        shutting_down = [ ];
        started = [ ];
        theme_mode_changed = [ ];
        wallpaper_changed = [ ];
        wifi_disabled = [ ];
        wifi_enabled = [ ];
      };
      hot_corners = {
        bottom_left = {
          action = "none";
          command = "";
        };
        bottom_right = {
          action = "none";
          command = "";
        };
        delay_ms = 0;
        enabled = false;
        top_left = {
          action = "none";
          command = "";
        };
        top_right = {
          action = "none";
          command = "";
        };
      };
      idle = {
        behavior = {
          lock = {
            action = "lock";
            command = "";
            enabled = false;
            locked_timeout = 0.0;
            resume_command = "";
            timeout = 600.0;
          };
          lock-and-suspend = {
            action = "lock_and_suspend";
            command = "";
            enabled = false;
            locked_timeout = 0.0;
            resume_command = "";
            timeout = 900.0;
          };
          screen-off = {
            action = "screen_off";
            command = "";
            enabled = false;
            locked_timeout = 0.0;
            resume_command = "";
            timeout = 660.0;
          };
        };
        behavior_order = [
          "lock"
          "screen-off"
          "lock-and-suspend"
        ];
        pre_action_fade_seconds = 2.0;
      };
      keybinds = {
        cancel = [
          "Escape"
        ];
        copy = [
          "Ctrl+c"
        ];
        delete = [
          "Delete"
        ];
        down = [
          "Down"
        ];
        left = [
          "Left"
        ];
        right = [
          "Right"
        ];
        save = [
          "Ctrl+s"
        ];
        tab_next = [
          "Tab"
        ];
        tab_previous = [
          "Shift+ISO_Left_Tab"
        ];
        up = [
          "Up"
        ];
        validate = [
          "Return"
          "KP_Enter"
          "space"
        ];
      };
      location = {
        address = "Eitorf, Germany";
        auto_locate = false;
        custom_schedule = false;
        sunrise = "";
        sunset = "";
      };
      lockscreen = {
        allow_empty_password = false;
        blur_intensity = 0.5;
        blurred_desktop = false;
        enabled = true;
        fingerprint = true;
        lock_before_suspend = true;
        monitors = [ ];
        tint_intensity = 0.0;
        wallpaper = "";
      };
      lockscreen_widgets = {
        enabled = true;
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        schema_version = 2;
        widget = {
          "lockscreen-login-box@DP-1" = {
            box_height = 196.0;
            box_width = 810.0;
            cx = 1280.0;
            cy = 1258.0;
            enabled = true;
            output = "DP-1";
            placement_height = 1440.0;
            placement_width = 2560.0;
            rotation = 0.0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
            type = "login_box";
          };
          "lockscreen-login-box@FALLBACK" = {
            box_height = 196.0;
            box_width = 810.0;
            cx = 960.0;
            cy = 898.0;
            enabled = true;
            output = "FALLBACK";
            placement_height = 1080.0;
            placement_width = 1920.0;
            rotation = 0.0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
            type = "login_box";
          };
          "lockscreen-login-box@WAYLAND-1" = {
            box_height = 196.0;
            box_width = 720.0;
            cx = 603.9996948242188;
            cy = 1237.9996337890625;
            enabled = true;
            output = "WAYLAND-1";
            placement_height = 1420.0;
            placement_width = 1207.0;
            rotation = 0.0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
            type = "login_box";
          };
          "lockscreen-login-box@eDP-1" = {
            box_height = 82.0;
            box_width = 720.0;
            cx = 944.0;
            cy = 1027.0;
            enabled = true;
            output = "eDP-1";
            placement_height = 0.0;
            placement_width = 0.0;
            rotation = 0.0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.0;
              background_radius = 0.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 32.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = false;
              show_media = false;
              show_session_buttons = false;
              show_unlock_hint = false;
              show_weather = false;
            };
            type = "login_box";
          };
          lockscreen-widget-0000000000000003 = {
            box_height = 240.0;
            box_width = 656.0;
            cx = 944.0;
            cy = 868.0;
            enabled = true;
            output = "eDP-1";
            placement_height = 0.0;
            placement_width = 0.0;
            rotation = 0.0;
            settings = {
              background = true;
              background_color = "on_primary";
              background_opacity = 1.0;
              background_padding = 0;
              background_radius = 32;
              center_text = true;
              clock_style = "digital";
              color = "primary";
              font_family = "Google Sans Flex";
              format = "{:%H:%M:%S}";
              shadow = false;
            };
            type = "clock";
          };
        };
        widget_order = [
          "lockscreen-login-box@FALLBACK"
          "lockscreen-login-box@WAYLAND-1"
          "lockscreen-login-box@DP-1"
          "lockscreen-login-box@eDP-1"
          "lockscreen-widget-0000000000000003"
        ];
      };
      nightlight = {
        enabled = false;
        force = false;
        temperature_day = 6500;
        temperature_night = 4000;
      };
      notification = {
        background_opacity = 0.9700000286102295;
        border = true;
        collapse_on_dismiss = true;
        enable_daemon = true;
        history_retention_hours = 24;
        layer = "overlay";
        max_visible = 0;
        monitors = [ ];
        offset_x = 20;
        offset_y = 8;
        position = "top_right";
        scale = 1.2000000476837158;
        show_actions = true;
        show_app_name = true;
      };
      osd = {
        background_opacity = 1.0;
        border = true;
        enabled = true;
        kinds = {
          bluetooth = true;
          brightness = true;
          caffeine = true;
          dnd = true;
          keyboard_backlight = true;
          keyboard_layout = true;
          lock_keys = true;
          media = true;
          nightlight = true;
          power_profile = true;
          privacy = true;
          volume = true;
          volume_input = true;
          volume_output = true;
          wifi = true;
        };
        monitors = [ ];
        offset_x = 20;
        offset_y = 200;
        orientation = "horizontal";
        position = "bottom_center";
        position_vertical = "top_center";
        scale = 1.2000000476837158;
      };
      plugin_settings = {
        "nightwatch75/todo" = {
          panel_open_near_click = false;
        };
        "noctalia/notes" = {
          panel_placement = "attached";
        };
        "yocraft/qrcode" = {
          generate_button = false;
          size = 100;
          titlebar = false;
        };
      };
      plugins = {
        auto_update = "all";
        enabled = [
          "nightwatch75/file-search"
          "yuuto/calculator"
          "yocraft/qrcode"
          "nightwatch75/todo"
          "noctalia/notes"
        ];
        source = [
          {
            enabled = true;
            kind = "git";
            location = "https://github.com/noctalia-dev/official-plugins";
            name = "official";
          }
          {
            enabled = true;
            kind = "git";
            location = "https://github.com/noctalia-dev/community-plugins";
            name = "community";
          }
        ];
      };
      shell = {
        animation = {
          enabled = true;
          speed = 1.0;
        };
        app_icon_colorize = false;
        avatar_path = "/home/lev/Pictures/hole.png";
        button_borders = false;
        card_borders = false;
        clipboard_auto_paste = "auto";
        clipboard_confirm_clear_history = true;
        clipboard_enabled = true;
        clipboard_history_max_entries = 100;
        clipboard_image_action_command = "";
        clipboard_keep_from_closed_apps = true;
        corner_radius_scale = 1.5;
        date_format = "%A, %x";
        disable_mipmaps = false;
        external_ip_enabled = false;
        font_family = "Google Sans Flex";
        greeter_sync = {
          auto_sync = false;
        };
        input_borders = true;
        keyboard_layout = {
          custom_labels = {
            "English (US)" = "en";
            Russian = "ru";
          };
        };
        launch_apps_as_systemd_services = false;
        launch_apps_custom_command = "";
        launcher = {
          app_grid = false;
          auto_paste = "auto";
          categories = false;
          compact = false;
          dmenu = { };
          fetch_exchange_rates = false;
          pinned = [ ];
          provider_prefix = "/";
          providers = {
            calculator = {
              global = false;
              prefix = "";
            };
          };
          show_app_actions = false;
          show_app_origin_indicator = true;
          show_icons = true;
          sort_by_usage = true;
        };
        mpris = {
          blacklist = [ ];
        };
        niri_overview_type_to_launch_enabled = false;
        offline_mode = false;
        panel = {
          borders = true;
          clipboard_placement = "floating";
          clipboard_position = "center";
          control_center_placement = "attached";
          control_center_position = "auto";
          floating_layer = "overlay";
          floating_offset = 8;
          launcher_placement = "floating";
          launcher_position = "center";
          list_item_background = false;
          open_near_click_clipboard = false;
          open_near_click_control_center = false;
          open_near_click_launcher = false;
          open_near_click_session = false;
          open_near_click_wallpaper = false;
          polkit_placement = "floating";
          polkit_position = "center";
          session_placement = "attached";
          session_position = "auto";
          shadow = true;
          transparency_mode = "solid";
          wallpaper_placement = "floating";
          wallpaper_position = "center";
        };
        password_style = "default";
        polkit_agent = false;
        popup_borders = true;
        popup_shadows = false;
        privacy = {
          cam_filter_regex = "";
          mic_filter_regex = "";
          screen_filter_regex = "";
        };
        screen_corners = {
          enabled = true;
          size = 30;
        };
        screen_time_enabled = true;
        screenshot = {
          confirm_region = false;
          copy_to_clipboard = true;
          directory = "";
          filename_pattern = "";
          freeze_screen = true;
          pipe_command = "";
          pipe_to_command = false;
          remember_last_region = false;
          save_to_file = false;
          show_cursor = true;
        };
        session = {
          actions = [
            {
              action = "lock";
              command = "";
              countdown_seconds = 0.0;
              enabled = true;
              glyph = "";
              label = "";
              shortcut = "1";
              variant = "default";
            }
            {
              action = "logout";
              command = "";
              countdown_seconds = 0.0;
              enabled = true;
              glyph = "";
              label = "";
              shortcut = "2";
              variant = "default";
            }
            {
              action = "lock_and_suspend";
              command = "";
              countdown_seconds = 0.0;
              enabled = true;
              glyph = "";
              label = "";
              shortcut = "3";
              variant = "default";
            }
            {
              action = "reboot";
              command = "";
              countdown_seconds = 0.0;
              enabled = true;
              glyph = "";
              label = "";
              shortcut = "4";
              variant = "default";
            }
            {
              action = "shutdown";
              command = "";
              countdown_seconds = 0.0;
              enabled = true;
              glyph = "";
              label = "";
              shortcut = "5";
              variant = "destructive";
            }
          ];
          grid = false;
          grid_columns = 3;
          power = { };
          show_shortcuts = true;
        };
        settings_show_advanced = true;
        settings_window_translucent = false;
        setup_wizard_enabled = true;
        shadow = {
          alpha = 0.550000011920929;
          direction = "down";
        };
        shared_gl_context = true;
        show_location = true;
        telemetry_enabled = false;
        time_format = "{:%H:%M}";
      };
      storage = {
        key_file = "";
        key_source = "secret-service";
      };
      system = {
        monitor = {
          cpu_freq_activity_threshold = 2.5;
          cpu_freq_critical_threshold = 4.5;
          cpu_poll_seconds = 2.0;
          cpu_temp_activity_threshold = 60.0;
          cpu_temp_critical_threshold = 85.0;
          cpu_temp_sensor_path = "";
          cpu_usage_activity_threshold = 50.0;
          cpu_usage_critical_threshold = 90.0;
          disk_free_activity_threshold = 80.0;
          disk_free_critical_threshold = 95.0;
          disk_free_pct_activity_threshold = 80.0;
          disk_free_pct_critical_threshold = 95.0;
          disk_poll_seconds = 10.0;
          disk_used_activity_threshold = 80.0;
          disk_used_critical_threshold = 95.0;
          disk_used_pct_activity_threshold = 80.0;
          disk_used_pct_critical_threshold = 95.0;
          enabled = true;
          gpu_poll_seconds = 5.0;
          gpu_temp_activity_threshold = 60.0;
          gpu_temp_critical_threshold = 85.0;
          gpu_usage_activity_threshold = 50.0;
          gpu_usage_critical_threshold = 95.0;
          gpu_vram_activity_threshold = 50.0;
          gpu_vram_critical_threshold = 90.0;
          memory_poll_seconds = 2.0;
          net_rx_activity_threshold = 1.0;
          net_rx_critical_threshold = 50.0;
          net_tx_activity_threshold = 1.0;
          net_tx_critical_threshold = 50.0;
          network_poll_seconds = 3.0;
          ram_pct_activity_threshold = 60.0;
          ram_pct_critical_threshold = 90.0;
          swap_pct_activity_threshold = 20.0;
          swap_pct_critical_threshold = 80.0;
        };
      };
      theme = {
        builtin = "Ayu";
        community_palette = "Tomorrow";
        custom_palette = "torii-ts";
        mode = "dark";
        pure_black_dark = false;
        source = "wallpaper";
        templates = {
          builtin_ids = [
            "btop"
          ];
          community_ids = [
            "antigravity"
            "zen-browser"
            "tmux"
            "yazi"
          ];
          enable_builtin_templates = true;
          enable_community_templates = true;
          user = {
            kitty = {
              compare_to = "";
              enabled = true;
              index = 0;
              input_path = "templates/kitty.conf";
              output_path = [
                "$XDG_CACHE_HOME/noctalia/kitty-theme.conf"
              ];
              output_path_dynamic = "";
              post_action = "";
              post_hook = "pkill -f -USR1 kitty";
              pre_hook = "";
            };
            neovim = {
              compare_to = "";
              enabled = true;
              index = 0;
              input_path = "templates/neovim.lua";
              output_path = [
                "$XDG_CACHE_HOME/noctalia/matugen.lua"
              ];
              output_path_dynamic = "";
              post_action = "";
              post_hook = "pkill -f -SIGUSR1 nvim";
              pre_hook = "";
            };
            telegram = {
              compare_to = "";
              enabled = true;
              index = 0;
              input_path = "templates/telegram.tdesktop-theme";
              output_path = [
                "$XDG_CACHE_HOME/noctalia/telegram/colors.tdesktop-theme"
              ];
              output_path_dynamic = "";
              post_action = "";
              post_hook = "kitty +runpy \"import runpy; runpy.run_path('$HOME/.config/noctalia/scripts/pack-telegram.py')\"";
              pre_hook = "";
            };
          };
        };
        wallpaper_scheme = "m3-tonal-spot";
      };
      wallpaper = {
        automation = {
          enabled = false;
          interval_seconds = 1800;
          order = "random";
          recursive = true;
        };
        directory = "";
        directory_dark = "";
        directory_light = "";
        edge_smoothness = 0.30000001192092896;
        enabled = true;
        fill_color = "";
        fill_mode = "crop";
        per_monitor_directories = false;
        transition = [
          "zoom"
        ];
        transition_duration = 1500.0;
        transition_on_startup = false;
      };
      weather = {
        effects = true;
        enabled = true;
        refresh_minutes = 30;
        unit = "metric";
      };
      widget = {
        active_window = {
          icon_size = 14.0;
          max_length = 260.0;
          min_length = 80.0;
          title_scroll = "none";
          type = "active_window";
        };
        battery = {
          display_mode = "none";
          scale = 1.5;
          type = "battery";
        };
        bluetooth = {
          scale = 1.5;
          type = "bluetooth";
        };
        caffeine = {
          scale = 1.5;
          type = "caffeine";
        };
        clipboard = {
          scale = 1.5;
          type = "clipboard";
        };
        clock = {
          actions = {
            left = "panel-toggle control-center home";
          };
          color = "primary";
          scale = 1.7;
          type = "clock";
        };
        cpu = {
          stat = "cpu_usage";
          type = "sysmon";
        };
        date = {
          format = "{:%a %d %b}";
          type = "clock";
        };
        input_volume = {
          device = "input";
          type = "volume";
        };
        keyboard_layout = {
          hide_when_single_layout = false;
          scale = 1.5;
          show_glyph = false;
          type = "keyboard_layout";
        };
        lock_keys = {
          display = "short";
          hide_when_off = false;
          show_caps_lock = true;
          show_num_lock = true;
          show_scroll_lock = false;
          type = "lock_keys";
        };
        media = {
          art_size = 16.0;
          max_length = 220.0;
          min_length = 80.0;
          title_scroll = "always";
          type = "media";
        };
        network_rx = {
          stat = "net_rx";
          type = "sysmon";
        };
        network_tx = {
          stat = "net_tx";
          type = "sysmon";
        };
        notes = {
          scale = 1.5;
          type = "noctalia/notes:notes";
        };
        output_volume = {
          device = "output";
          type = "volume";
        };
        power_profile = {
          scale = 1.5;
          type = "power_profile";
        };
        ram = {
          stat = "ram_used";
          type = "sysmon";
        };
        screenshot = {
          glyph = "border-corners";
          scale = 1.5;
          type = "screenshot";
        };
        session = {
          scale = 1.5;
          type = "session";
        };
        settings = {
          actions = {
            left = "settings-toggle";
          };
          scale = 1.5;
          type = "settings";
        };
        spacer = {
          interactive = false;
          type = "spacer";
        };
        temp = {
          stat = "cpu_temp";
          type = "sysmon";
        };
        todo = {
          scale = 1.5;
          type = "nightwatch75/todo:todo";
        };
        volume = {
          scale = 1.5;
          show_label = false;
          type = "volume";
        };
        widget = {
          scale = 1.5;
          type = "yocraft/qrcode:widget";
        };
        workspaces = {
          active_pill_size = 2.0;
          scale = 1.5;
          type = "workspaces";
          urgent_color = "secondary";
        };
      };
    };

    customPalettes = {
      house-mc = {
        dark = {
          mError = "#ffb4ab";
          mHover = "#e0bdff";
          mOnError = "#690005";
          mOnHover = "#41205f";
          mOnPrimary = "#003736";
          mOnSecondary = "#0f3635";
          mOnSurface = "#dfe3e2";
          mOnSurfaceVariant = "#bcc9c8";
          mOnTertiary = "#41205f";
          mOutline = "#3d4948";
          mPrimary = "#72dbd9";
          mSecondary = "#a7cecc";
          mShadow = "#000000";
          mSurface = "#0f1414";
          mSurfaceVariant = "#1b2120";
          mTertiary = "#e0bdff";
          terminal = {
            background = "#0f1414";
            bright = {
              black = "#879392";
              blue = "#e0bdff";
              cyan = "#a7cecc";
              green = "#72dbd9";
              magenta = "#6ed7d5";
              red = "#ffb4ab";
              white = "#dfe3e2";
              yellow = "#a7cecc";
            };
            cursor = "#dfe3e2";
            cursorText = "#0f1414";
            foreground = "#dfe3e2";
            normal = {
              black = "#3d4948";
              blue = "#e0bdff";
              cyan = "#a7cecc";
              green = "#72dbd9";
              magenta = "#6ed7d5";
              red = "#ffb4ab";
              white = "#dfe3e2";
              yellow = "#a7cecc";
            };
            selectionBg = "#3d4948";
            selectionFg = "#bcc9c8";
          };
        };
        light = {
          mError = "#ba1a1a";
          mHover = "#715091";
          mOnError = "#ffffff";
          mOnHover = "#ffffff";
          mOnPrimary = "#ffffff";
          mOnSecondary = "#ffffff";
          mOnSurface = "#171d1c";
          mOnSurfaceVariant = "#3d4948";
          mOnTertiary = "#ffffff";
          mOutline = "#bcc9c8";
          mPrimary = "#006a69";
          mSecondary = "#406564";
          mShadow = "#000000";
          mSurface = "#f6faf9";
          mSurfaceVariant = "#eaefee";
          mTertiary = "#715091";
          terminal = {
            background = "#f6faf9";
            bright = {
              black = "#6d7979";
              blue = "#715091";
              cyan = "#557978";
              green = "#006a69";
              magenta = "#00807f";
              red = "#ba1a1a";
              white = "#171d1c";
              yellow = "#406564";
            };
            cursor = "#171d1c";
            cursorText = "#f6faf9";
            foreground = "#171d1c";
            normal = {
              black = "#d8e5e4";
              blue = "#715091";
              cyan = "#557978";
              green = "#006a69";
              magenta = "#00807f";
              red = "#ba1a1a";
              white = "#171d1c";
              yellow = "#406564";
            };
            selectionBg = "#d8e5e4";
            selectionFg = "#3d4948";
          };
        };
      };
      torii-ts = {
        dark = {
          mError = "#ffb4ab";
          mHover = "#a1d0c5";
          mOnError = "#690005";
          mOnHover = "#033730";
          mOnPrimary = "#293500";
          mOnSecondary = "#2d331b";
          mOnSurface = "#e4e3d7";
          mOnSurfaceVariant = "#c7c8b8";
          mOnTertiary = "#033730";
          mOutline = "#46483c";
          mPrimary = "#bcce80";
          mSecondary = "#c4caa9";
          mShadow = "#000000";
          mSurface = "#13140d";
          mSurfaceVariant = "#1f2019";
          mTertiary = "#a1d0c5";
          terminal = {
            background = "#13140d";
            bright = {
              black = "#909283";
              blue = "#a1d0c5";
              cyan = "#c4caa9";
              green = "#bcce80";
              magenta = "#bcce80";
              red = "#ffb4ab";
              white = "#e4e3d7";
              yellow = "#c4caa9";
            };
            cursor = "#e4e3d7";
            cursorText = "#13140d";
            foreground = "#e4e3d7";
            normal = {
              black = "#46483c";
              blue = "#a1d0c5";
              cyan = "#c4caa9";
              green = "#bcce80";
              magenta = "#bcce80";
              red = "#ffb4ab";
              white = "#e4e3d7";
              yellow = "#c4caa9";
            };
            selectionBg = "#46483c";
            selectionFg = "#c7c8b8";
          };
        };
        light = {
          mError = "#ba1a1a";
          mHover = "#3a665e";
          mOnError = "#ffffff";
          mOnHover = "#ffffff";
          mOnPrimary = "#ffffff";
          mOnSecondary = "#ffffff";
          mOnSurface = "#1b1c15";
          mOnSurfaceVariant = "#46483c";
          mOnTertiary = "#ffffff";
          mOutline = "#c7c8b8";
          mPrimary = "#556423";
          mSecondary = "#5b6146";
          mShadow = "#000000";
          mSurface = "#fbfaed";
          mSurfaceVariant = "#efeee2";
          mTertiary = "#3a665e";
          terminal = {
            background = "#fbfaed";
            bright = {
              black = "#76786b";
              blue = "#3a665e";
              cyan = "#717658";
              green = "#556423";
              magenta = "#6a7a2c";
              red = "#ba1a1a";
              white = "#1b1c15";
              yellow = "#5b6146";
            };
            cursor = "#1b1c15";
            cursorText = "#fbfaed";
            foreground = "#1b1c15";
            normal = {
              black = "#e3e4d3";
              blue = "#3a665e";
              cyan = "#717658";
              green = "#556423";
              magenta = "#6a7a2c";
              red = "#ba1a1a";
              white = "#1b1c15";
              yellow = "#5b6146";
            };
            selectionBg = "#e3e4d3";
            selectionFg = "#46483c";
          };
        };
      };
    };
  };

  xdg.configFile = {
    "noctalia/templates/kitty.conf".text = ''
color0 {{colors.terminal_normal_black.default.hex}}
color1 {{colors.terminal_normal_red.default.hex}}
color2 {{colors.terminal_normal_green.default.hex}}
color3 {{colors.terminal_normal_yellow.default.hex}}
color4 {{colors.terminal_normal_blue.default.hex}}
color5 {{colors.terminal_normal_magenta.default.hex}}
color6 {{colors.terminal_normal_cyan.default.hex}}
color7 {{colors.terminal_normal_white.default.hex}}
color8 {{colors.terminal_bright_black.default.hex}}
color9 {{colors.terminal_bright_red.default.hex}}
color10 {{colors.terminal_bright_green.default.hex}}
color11 {{colors.terminal_bright_yellow.default.hex}}
color12 {{colors.terminal_bright_blue.default.hex}}
color13 {{colors.terminal_bright_magenta.default.hex}}
color14 {{colors.terminal_bright_cyan.default.hex}}
color15 {{colors.terminal_bright_white.default.hex}}

cursor                {{colors.terminal_cursor.default.hex}}
cursor_text_color     {{colors.terminal_cursor_text.default.hex}}
background            {{colors.terminal_background.default.hex}}
foreground            {{colors.terminal_foreground.default.hex}}
selection_foreground  {{colors.terminal_selection_fg.default.hex}}
selection_background  {{colors.terminal_selection_bg.default.hex}}
active_border_color   {{colors.primary.default.hex}}
inactive_border_color {{colors.surface_variant.default.hex}}
url_color             {{colors.primary.default.hex}}

active_tab_foreground   {{colors.on_primary.default.hex}}
active_tab_background   {{colors.primary.default.hex}}
inactive_tab_foreground {{colors.on_surface_variant.default.hex}}
inactive_tab_background {{colors.surface_variant.default.hex}}
cursor_trail_color      {{colors.on_surface_variant.default.hex}}
'';

    "noctalia/templates/neovim.lua".text = ''
local M = {}

function M.setup()
  vim.g.colors_name = 'base16'

  require('base16-colorscheme').setup({
    base00 = '{{colors.surface.default.hex}}',
    base01 = '{{colors.surface_container.default.hex}}',
    base02 = '{{colors.surface_container_high.default.hex}}',
    base03 = '{{colors.outline.default.hex}}',
    base04 = '{{colors.on_surface_variant.default.hex}}',
    base05 = '{{colors.on_surface.default.hex}}',
    base06 = '{{colors.on_surface.default.hex}}',
    base07 = '{{colors.on_background.default.hex}}',
    base08 = '{{colors.error.default.hex}}',
    base09 = '{{colors.tertiary.default.hex}}',
    base0A = '{{colors.secondary.default.hex}}',
    base0B = '{{colors.primary.default.hex}}',
    base0C = '{{colors.tertiary_fixed_dim.default.hex}}',
    base0D = '{{colors.primary_fixed_dim.default.hex}}',
    base0E = '{{colors.secondary_fixed_dim.default.hex}}',
    base0F = '{{colors.secondary_fixed.default.hex}}',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '{{colors.on_surface.default.hex}}',          bg = '{{colors.surface.default.hex}}' })
  hi('TelescopeBorder',         { fg = '{{colors.outline.default.hex}}',             bg = '{{colors.surface.default.hex}}' })
  hi('TelescopePromptNormal',   { fg = '{{colors.on_surface.default.hex}}',          bg = '{{colors.surface.default.hex}}' })
  hi('TelescopePromptBorder',   { fg = '{{colors.outline.default.hex}}',             bg = '{{colors.surface.default.hex}}' })
  hi('TelescopePromptPrefix',   { fg = '{{colors.primary.default.hex}}',             bg = '{{colors.surface.default.hex}}' })
  hi('TelescopePromptCounter',  { fg = '{{colors.on_surface_variant.default.hex}}',  bg = '{{colors.surface.default.hex}}' })
  hi('TelescopePromptTitle',    { fg = '{{colors.surface.default.hex}}',             bg = '{{colors.primary.default.hex}}' })
  hi('TelescopePreviewTitle',   { fg = '{{colors.surface.default.hex}}',             bg = '{{colors.secondary.default.hex}}' })
  hi('TelescopeResultsTitle',   { fg = '{{colors.surface.default.hex}}',             bg = '{{colors.tertiary.default.hex}}' })
  hi('TelescopeSelection',      { fg = '{{colors.on_surface.default.hex}}',          bg = '{{colors.surface_container_high.default.hex}}' })
  hi('TelescopeSelectionCaret', { fg = '{{colors.primary.default.hex}}',             bg = '{{colors.surface_container_high.default.hex}}' })
  hi('TelescopeMatching',       { fg = '{{colors.primary.default.hex}}',             bold = true })

  hi('NeoTreeNormal',           { fg = '{{colors.on_surface.default.hex}}',          bg = '{{colors.surface_container_low.default.hex}}' })
  hi('NeoTreeNormalNC',         { fg = '{{colors.on_surface.default.hex}}',          bg = '{{colors.surface_container_low.default.hex}}' })
  hi('SnacksNormal',            { fg = '{{colors.on_surface.default.hex}}',          bg = '{{colors.surface.default.hex}}' })
  hi('WhichKeyNormal',          { fg = '{{colors.on_surface.default.hex}}',          bg = '{{colors.surface.default.hex}}' })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
    if package.loaded['lualine'] then
      pcall(function()
        require('lualine').setup()
      end)
    end
  end)
)

return M
'';

    "noctalia/templates/telegram.tdesktop-theme".text = ''
// Material You theme for Telegram Desktop
// Generated by Noctalia's Template Processor

COLOR_GRAY: {{colors.outline.default.hex}};
COLOR_DARK: {{colors.surface_variant.default.hex}};

windowBg: {{colors.background.default.hex}}; // Main background
windowFg: {{colors.on_background.default.hex}}; // Main text
windowBgOver: {{colors.surface_variant.default.hex}}; // Generic background on hover
windowBgRipple: {{colors.surface_variant.default.hex}}; // Ripple effect
windowFgOver: {{colors.on_surface_variant.default.hex}}; // Text on hover
windowSubTextFg: {{colors.outline.default.hex}}; // Minor text
windowSubTextFgOver: {{colors.outline.default.hex}}; // Minor text on hover
windowBoldFg: {{colors.on_background.default.hex}}; // Bold text
windowBoldFgOver: {{colors.on_surface_variant.default.hex}}; // Bold text on hover
windowBgActive: {{colors.primary.default.hex}}; // Active items background
windowFgActive: {{colors.on_primary.default.hex}}; // Active items text
windowActiveTextFg: {{colors.primary.default.hex}}; // Active items text
windowShadowFg: {{colors.shadow.default.hex}}; // Window shadow
windowShadowFgFallback: {{colors.shadow.default.hex}}; // Fallback for shadow
historyOutIconFg: {{colors.primary.default.hex}};
historyIconFgInverted: {{colors.on_surface.default.hex}};

msgServiceBg: {{colors.surface_variant.default.hex}};
msgServiceBgSelected: {{colors.secondary_container.default.hex}};
msgServiceFg: {{colors.on_surface.default.hex}};
historyUnreadBarBg: {{colors.surface_variant.default.hex}}; // Unread messages banner background
historyUnreadBarFg: {{colors.on_surface.default.hex}}; // Unread messages banner text
historyUnreadBarBorder: {{colors.shadow.default.hex}}00; // Unread messages banner border
botKbBg: {{colors.surface_variant.default.hex}}; // Inline bot keyboard button background
botKbDownBg: {{colors.secondary_container.default.hex}}; // Inline bot keyboard button pressed
msgBotKbIconFg: {{colors.on_surface_variant.default.hex}}; // Inline bot keyboard button icon
msgOutBg: {{colors.secondary_container.default.hex}};
msgOutBgSelected: {{colors.surface_container_high.default.hex}};
msgOutServiceFg: {{colors.on_surface.default.hex}};
historyTextOutFg: {{colors.on_surface.default.hex}}; // Outgoing bubble text
msgOutDateFg: {{colors.on_surface.default.hex}};
historySentIconFg: {{colors.on_surface.default.hex}};
msgOutDateFgSelected: {{colors.on_surface.default.hex}};
msgDateImgFg: {{colors.on_surface.default.hex}};
dialogsSentIconFg: {{colors.primary.default.hex}};
dialogsSentIconFgOver: {{colors.primary.default.hex}};
dialogsOnlineBadgeFg: {{colors.primary.default.hex}};


shadowFg: {{colors.shadow.default.hex}}; // General shadow
slideFadeOutBg: {{colors.background.default.hex}};
slideFadeOutShadowFg: {{colors.shadow.default.hex}};

imageBg: {{colors.surface.default.hex}};
imageBgTransparent: {{colors.surface.default.hex}};

activeButtonBg: {{colors.primary.default.hex}}; // Active button background
activeButtonBgOver: {{colors.primary_container.default.hex}}; // Active button hover background
activeButtonBgRipple: {{colors.on_primary_container.default.hex}}; // Active button ripple
activeButtonFg: {{colors.on_primary.default.hex}}; // Active button text
activeButtonFgOver: {{colors.on_primary_container.default.hex}}; // Active button hover text
activeButtonSecondaryFg: {{colors.on_primary.default.hex}}; // Active button secondary text
activeButtonSecondaryFgOver: {{colors.on_primary_container.default.hex}}; // Active button secondary hover text
activeLineFg: {{colors.on_surface.default.hex}};
dialogsBgActive: {{colors.secondary_container.default.hex}};
dialogsNameFg: {{colors.on_surface.default.hex}}; // Chat list name text
dialogsNameFgActive: {{colors.on_surface.default.hex}}; // Selected chat name text (same as bubble text)
dialogsTextFgActive: {{colors.on_surface.default.hex}}; // Selected chat preview text (same as bubble text)
dialogsDateFgActive: {{colors.on_surface.default.hex}}; // Selected chat date text (same as bubble text)
sideBarBg: {{colors.surface_container_lowest.default.hex}}; // Filters side bar background
sideBarBgActive: {{colors.surface_container.default.hex}}; // Filters side bar active background
sideBarBgRipple: {{colors.surface_container_low.default.hex}}; // Filters side bar ripple effect
sideBarTextFg: {{colors.outline.default.hex}}; // Filters side bar text
sideBarTextFgActive: {{colors.primary.default.hex}}; // Filters side bar active item text
sideBarIconFg: {{colors.outline.default.hex}}; // Filters side bar icon
sideBarIconFgActive: {{colors.primary.default.hex}}; // Filters side bar active item icon
sideBarBadgeBg: {{colors.primary.default.hex}}; // Filters side bar badge background
sideBarBadgeBgMuted: {{colors.outline.default.hex}}; // Filters side bar muted badge background
sideBarBadgeFg: {{colors.on_primary.default.hex}}; // Filters side bar badge text


lightButtonBg: {{colors.surface.default.hex}}; // Light button background
lightButtonBgOver: {{colors.surface_variant.default.hex}}; // Light button hover background
lightButtonBgRipple: {{colors.primary.default.hex}}; // Light button ripple
lightButtonFg: {{colors.on_surface.default.hex}}; // Light button text
lightButtonFgOver: {{colors.on_surface_variant.default.hex}}; // Light button hover text

attentionButtonFg: {{colors.error.default.hex}};
attentionButtonFgOver: {{colors.error.default.hex}};
attentionButtonBgOver: {{colors.error_container.default.hex}};
attentionButtonBgRipple: {{colors.on_error_container.default.hex}};

outlineButtonBg: {{colors.surface.default.hex}}; // Outline button background
outlineButtonBgOver: {{colors.surface_variant.default.hex}}; // Outline button hover background
outlineButtonOutlineFg: {{colors.primary.default.hex}}; // Outline button color
outlineButtonBgRipple: {{colors.primary.default.hex}}; // Outline button ripple

menuBg: {{colors.surface.default.hex}};
menuBgOver: {{colors.surface_variant.default.hex}};
menuBgRipple: {{colors.primary.default.hex}};
menuIconFg: {{colors.on_surface.default.hex}};
menuIconFgOver: {{colors.on_surface_variant.default.hex}};
menuSubmenuArrowFg: {{colors.outline.default.hex}};
menuFgDisabled: {{colors.outline.default.hex}};
menuSeparatorFg: {{colors.outline.default.hex}};

scrollBarBg: {{colors.primary.default.hex}}40; // Scroll bar background (40% opacity)
scrollBarBgOver: {{colors.primary.default.hex}}60; // Scroll bar hover background (60% opacity)
scrollBg: {{colors.surface_variant.default.hex}}40; // Scroll bar track (40% opacity)
scrollBgOver: {{colors.surface_variant.default.hex}}60; // Scroll bar track on hover (60% opacity)
historyScrollBarBg: {{colors.on_surface.default.hex}}7a; // Chat scroll bar (48% opacity)
historyScrollBarBgOver: {{colors.on_surface.default.hex}}bc; // Chat scroll bar on hover (74% opacity)
historyScrollBg: {{colors.on_surface.default.hex}}4c; // Chat scroll bar track (30% opacity)
historyScrollBgOver: {{colors.on_surface.default.hex}}6b; // Chat scroll bar track on hover (42% opacity)

smallCloseIconFg: {{colors.outline.default.hex}};
smallCloseIconFgOver: {{colors.on_surface_variant.default.hex}};

radialFg: {{colors.primary.default.hex}};
radialBg: {{colors.surface.default.hex}};

placeholderFg: {{colors.outline.default.hex}}; // Placeholder text
placeholderFgActive: {{colors.primary.default.hex}}; // Active placeholder text
inputBorderFg: {{colors.outline.default.hex}}; // Input border
filterInputBorderFg: {{colors.outline.default.hex}}; // Search input border
filterInputInactiveBg: {{colors.surface.default.hex}}; // Inactive search input background
checkboxFg: {{colors.primary.default.hex}}; // Checkbox color

titleBg: {{colors.surface.default.hex}}; // Window title background
titleShadow: {{colors.shadow.default.hex}};
titleButtonFg: {{colors.on_surface.default.hex}}; // Title button color
titleButtonBgOver: {{colors.surface_variant.default.hex}}; // Title button hover background
titleButtonFgOver: {{colors.on_surface_variant.default.hex}}; // Title button hover color
titleButtonCloseBgOver: {{colors.error.default.hex}};
titleButtonCloseFgOver: {{colors.on_error.default.hex}};
titleFgActive: {{colors.on_surface.default.hex}}; // Active title text
titleFg: {{colors.on_surface.default.hex}}; // Inactive title text

trayCounterBg: {{colors.error.default.hex}}; // Tray counter background
trayCounterBgMute: {{colors.outline.default.hex}}; // Muted tray counter background
trayCounterFg: {{colors.on_error.default.hex}}; // Tray counter text
trayCounterBgMacInvert: {{colors.error.default.hex}}; // Mac tray counter
trayCounterFgMacInvert: {{colors.on_error.default.hex}}; // Mac tray counter text

layerBg: {{colors.surface.default.hex}}99; // Layer background (60% opacity)

cancelIconFg: {{colors.error.default.hex}}; // Cancel icon
cancelIconFgOver: {{colors.error.default.hex}}; // Cancel icon on hover

boxBg: {{colors.surface.default.hex}}; // Box background
boxTextFg: {{colors.on_surface.default.hex}}; // Box text
boxTextFgGood: {{colors.primary.default.hex}}; // Box good text
boxTextFgError: {{colors.error.default.hex}}; // Box error text
boxTitleFg: {{colors.on_surface.default.hex}}; // Box title text
boxSearchBg: {{colors.surface.default.hex}}; // Box search field background
boxSearchCancelIconFg: {{colors.error.default.hex}}; // Box search cancel icon
boxSearchCancelIconFgOver: {{colors.error.default.hex}}; // Box search cancel icon on hover

contactsBg: {{colors.surface.default.hex}}; // Contacts background
contactsBgOver: {{colors.surface_variant.default.hex}}; // Contacts background on hover
contactsNameFg: {{colors.on_surface.default.hex}}; // Contact name
contactsStatusFg: {{colors.outline.default.hex}}; // Contact status
contactsStatusFgOver: {{colors.on_surface_variant.default.hex}}; // Contact status on hover
contactsStatusFgOnline: {{colors.primary.default.hex}}; // Online contact status

photoCropFadeBg: {{colors.surface.default.hex}}cc; // Photo crop fade background
photoCropPointFg: {{colors.primary.default.hex}}; // Photo crop points

chat_inBubbleSelected: #313244; // inbox selected chat background
chat_outBubbleSelected: #313244; // outbox selected chat background
'';

    "noctalia/scripts/pack-telegram.py".text = ''
import os
import sys
import zipfile
import subprocess
from pathlib import Path

home = Path.home()
colors_file = home / ".cache/noctalia/telegram/colors.tdesktop-theme"
if not colors_file.exists():
    alt_colors = home / ".config/telegram-desktop/themes/noctalia.tdesktop-theme"
    if alt_colors.exists():
        colors_file = alt_colors
    else:
        sys.exit(0)

# Output zip in user-accessible Downloads
out_zip = home / "Downloads/noctalia.tdesktop-theme"
out_zip.parent.mkdir(parents=True, exist_ok=True)

# Also save in cache
cache_zip = home / ".cache/noctalia/noctalia.tdesktop-theme"

# Find current wallpaper via noctalia msg wallpaper-get
wallpaper_path = None
try:
    res = subprocess.run(["noctalia", "msg", "wallpaper-get"], capture_output=True, text=True)
    wp = res.stdout.strip()
    if wp and os.path.exists(wp):
        wallpaper_path = wp
except Exception:
    pass

bg_jpg = Path("/tmp/telegram-background.jpg")
has_bg = False
if wallpaper_path and os.path.exists(wallpaper_path):
    try:
        subprocess.run(
            [
                "magick",
                wallpaper_path,
                "-resize",
                "1920x1080^",
                "-gravity",
                "center",
                "-extent",
                "1920x1080",
                "-blur",
                "0x25",
                str(bg_jpg),
            ],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        has_bg = bg_jpg.exists()
    except Exception:
        pass

# Pack into ZIP with colors and blurred background.jpg
with zipfile.ZipFile(out_zip, "w", zipfile.ZIP_DEFLATED, strict_timestamps=False) as zf:
    zf.write(colors_file, arcname="colors.tdesktop-theme")
    zf.write(colors_file, arcname="colors.tdesktop-palette")
    if has_bg:
        zf.write(bg_jpg, arcname="background.jpg")

try:
    cache_zip.write_bytes(out_zip.read_bytes())
except Exception:
    pass
'';
  };
}
