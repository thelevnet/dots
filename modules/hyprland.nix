{ config, pkgs, lib, ... }:

let
  inline = lib.generators.mkLuaInline;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    settings = {
      # Variables
      super = {
        _var = "SUPER";
      };
      ipc = {
        _var = "noctalia msg ";
      };

      # Autostart
      on = [
        {
          _args = [
            "hyprland.start"
            (inline ''
              function()
              	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
              	hl.exec_cmd("kitty")
              	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
              	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
              	hl.exec_cmd("systemctl --user start graphical-session.target")
              end
            '')
          ];
        }
      ];

      # Monitor
      monitor = {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = 1;
      };

      # Gesture
      gesture = {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      };

      # Settings & Layout Configs
      config = [
        {
          gestures = {
            workspace_swipe_distance = 700;
            workspace_swipe_cancel_ratio = 0.2;
            workspace_swipe_min_speed_to_force = 5;
            workspace_swipe_direction_lock = true;
            workspace_swipe_direction_lock_threshold = 10;
            workspace_swipe_create_new = true;
          };
          general = {
            gaps_in = 5;
            gaps_out = 10;
            gaps_workspaces = 50;
            border_size = 0;
            no_focus_fallback = true;
            allow_tearing = true;
            snap = {
              enabled = true;
              window_gap = 4;
              monitor_gap = 5;
              respect_gaps = true;
            };
          };
          decoration = {
            rounding_power = 2;
            rounding = 20;
            blur = {
              enabled = false;
              size = 3;
              passes = 2;
              vibrancy = 0.1696;
            };
            dim_inactive = true;
            dim_strength = 0.05;
            dim_special = 0.2;
          };
          animations = {
            enabled = true;
          };
          dwindle = {
            preserve_split = true;
            smart_split = false;
            smart_resizing = false;
          };
        }
        {
          input = {
            kb_layout = "us,ru";
            kb_options = "grp:caps_toggle";
            numlock_by_default = true;
            repeat_delay = 250;
            repeat_rate = 35;
            follow_mouse = 1;
            off_window_axis_events = 2;
            touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
              clickfinger_behavior = true;
              scroll_factor = 0.7;
            };
          };
          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            vrr = 1;
            mouse_move_enables_dpms = true;
            key_press_enables_dpms = true;
            animate_manual_resizes = false;
            animate_mouse_windowdragging = false;
            enable_swallow = false;
            swallow_regex = "(foot|kitty|allacritty|Alacritty)";
            on_focus_under_fullscreen = 2;
            allow_session_lock_restore = true;
            session_lock_xray = true;
            initial_workspace_tracking = false;
            focus_on_activate = true;
          };
          binds = {
            scroll_event_delay = 0;
            hide_special_on_workspace_change = true;
          };
          cursor = {
            zoom_factor = 1;
            zoom_rigid = false;
            zoom_disable_aa = true;
            hotspot_padding = 1;
          };
          xwayland = {
            force_zero_scaling = true;
          };
        }
      ];

      # Bezier Curves
      curve = [
        { _args = [ "expressiveFastSpatial" { type = "bezier"; points = [ [ 0.42 1.67 ] [ 0.21 0.90 ] ]; } ]; }
        { _args = [ "expressiveSlowSpatial" { type = "bezier"; points = [ [ 0.39 1.29 ] [ 0.35 0.98 ] ]; } ]; }
        { _args = [ "expressiveDefaultSpatial" { type = "bezier"; points = [ [ 0.38 1.21 ] [ 0.22 1.00 ] ]; } ]; }
        { _args = [ "emphasizedDecel" { type = "bezier"; points = [ [ 0.05 0.7 ] [ 0.1 1.0 ] ]; } ]; }
        { _args = [ "emphasizedAccel" { type = "bezier"; points = [ [ 0.3 0.0 ] [ 0.8 0.15 ] ]; } ]; }
        { _args = [ "standardDecel" { type = "bezier"; points = [ [ 0.0 0.0 ] [ 0.0 1.0 ] ]; } ]; }
        { _args = [ "menu_decel" { type = "bezier"; points = [ [ 0.1 1.0 ] [ 0.0 1.0 ] ]; } ]; }
        { _args = [ "menu_accel" { type = "bezier"; points = [ [ 0.52 0.03 ] [ 0.72 0.08 ] ]; } ]; }
        { _args = [ "stall" { type = "bezier"; points = [ [ 1.0 (-0.1) ] [ 0.7 0.85 ] ]; } ]; }
      ];

      # Animations
      animation = [
        # Windows
        { leaf = "windowsIn"; enabled = true; speed = 3; bezier = "emphasizedDecel"; style = "popin 80%"; }
        { leaf = "fadeIn"; enabled = true; speed = 3; bezier = "emphasizedDecel"; }
        { leaf = "windowsOut"; enabled = true; speed = 2; bezier = "emphasizedDecel"; style = "popin 90%"; }
        { leaf = "fadeOut"; enabled = true; speed = 2; bezier = "emphasizedDecel"; }
        { leaf = "windowsMove"; enabled = true; speed = 3; bezier = "emphasizedDecel"; style = "slide"; }
        { leaf = "border"; enabled = true; speed = 10; bezier = "emphasizedDecel"; }

        # Layers
        { leaf = "layersIn"; enabled = true; speed = 2.7; bezier = "emphasizedDecel"; style = "popin 93%"; }
        { leaf = "layersOut"; enabled = true; speed = 2.4; bezier = "menu_accel"; style = "popin 94%"; }

        # Fade
        { leaf = "fadeLayersIn"; enabled = true; speed = 0.5; bezier = "menu_decel"; }
        { leaf = "fadeLayersOut"; enabled = true; speed = 2.7; bezier = "stall"; }

        # Workspaces
        { leaf = "workspaces"; enabled = true; speed = 7; bezier = "menu_decel"; style = "slide"; }
        { leaf = "specialWorkspaceIn"; enabled = true; speed = 2.8; bezier = "emphasizedDecel"; style = "slidevert"; }
        { leaf = "specialWorkspaceOut"; enabled = true; speed = 1.2; bezier = "emphasizedAccel"; style = "slidevert"; }
      ];

      # Keybindings
      bind = [
        # System & Panel Controls
        { _args = [ (inline "super .. \"+Space\"") (inline "hl.dsp.exec_cmd(ipc .. \"panel-toggle launcher\")") ]; }
        { _args = [ (inline "super .. \"+A\"") (inline "hl.dsp.exec_cmd(ipc .. \"panel-toggle control-center\")") ]; }
        { _args = [ (inline "super .. \"+Slash\"") (inline "hl.dsp.exec_cmd(ipc .. \"settings-toggle\")") ]; }
        { _args = [ "ALT + Tab" (inline "hl.dsp.exec_cmd(ipc .. \"window-switcher\")") ]; }
        { _args = [ "CTRL + ALT + DELETE" (inline "hl.dsp.exec_cmd(ipc .. \"panel-toggle session\")") ]; }
        { _args = [ "Print" (inline ''hl.dsp.exec_cmd(ipc .. 'screenshot-fullscreen; notify-send "Screenshot"')'') ]; }

        # Window Management & Layouts
        { _args = [ (inline "super .. \"+C\"") (inline "hl.dsp.window.close()") ]; }
        { _args = [ (inline "super .. \"+V\"") (inline "hl.dsp.window.float({ action = \"toggle\" })") ]; }
        { _args = [ (inline "super .. \"+D\"") (inline "hl.dsp.window.fullscreen({ mode = \"maximized\", action = \"toggle\" })") ]; }
        { _args = [ (inline "super .. \"+F\"") (inline "hl.dsp.window.fullscreen({ mode = \"fullscreen\", action = \"toggle\" })") ]; }
        { _args = [ (inline "super .. \"+ALT+F\"") (inline "hl.dsp.window.fullscreen_state({ internal = 0, client = 3, action = \"toggle\" })") ]; }
        { _args = [ (inline "super .. \"+S\"") (inline "hl.dsp.workspace.toggle_special(\"special\")") ]; }
        { _args = [ (inline "super .. \"+Semicolon\"") (inline "hl.dsp.layout(\"splitratio -0.1\")") ]; }
        { _args = [ (inline "super .. \"+Apostrophe\"") (inline "hl.dsp.layout(\"splitratio +0.1\")") ]; }
        { _args = [ (inline "super .. \"+Backslash\"") (inline "hl.dsp.window.resize({ x = 1200, y = 800, \"exact\" })") ]; }
        { _args = [ "Home" (inline ''hl.dsp.exec_cmd("kitty --title fetch-float -- fetch --size 15.0 --no-info --infinite -s 2.0")'') ]; }

        # Apps
        { _args = [ (inline "super .. \"+Return\"") (inline "hl.dsp.exec_cmd(\"kitty\")") ]; }
        { _args = [ (inline "super .. \"+E\"") (inline "hl.dsp.exec_cmd(\"kitty yazi\")") ]; }
        { _args = [ (inline "super .. \"+W\"") (inline "hl.dsp.exec_cmd(\"zen\")") ]; }
        { _args = [ (inline "super .. \"+X\"") (inline "hl.dsp.exec_cmd(\"kitty nvim\")") ]; }
        { _args = [ (inline "super .. \"+Q\"") (inline "hl.dsp.exec_cmd(\"Telegram\")") ]; }

        # Mouse Bindings
        { _args = [ (inline "super .. \"+mouse:272\"") (inline "hl.dsp.window.drag()") { mouse = true; } ]; }
        { _args = [ (inline "super .. \"+mouse:274\"") (inline "hl.dsp.window.drag()") { mouse = true; } ]; }
        { _args = [ (inline "super .. \"+mouse:273\"") (inline "hl.dsp.window.resize()") { mouse = true; } ]; }

        # Media & Hardware Keys
        { _args = [ "XF86AudioRaiseVolume" (inline "hl.dsp.exec_cmd(ipc .. \"volume-up\")") ]; }
        { _args = [ "XF86AudioLowerVolume" (inline "hl.dsp.exec_cmd(ipc .. \"volume-down\")") ]; }
        { _args = [ "XF86AudioMute" (inline "hl.dsp.exec_cmd(ipc .. \"volume-mute\")") ]; }
        { _args = [ "XF86MonBrightnessUp" (inline "hl.dsp.exec_cmd(ipc .. \"brightness-up\")") ]; }
        { _args = [ "XF86MonBrightnessDown" (inline "hl.dsp.exec_cmd(ipc .. \"brightness-down\")") ]; }

        # Directional Focus
        { _args = [ (inline "super .. \"+left\"") (inline "hl.dsp.focus({ direction = \"l\" })") ]; }
        { _args = [ (inline "super .. \"+right\"") (inline "hl.dsp.focus({ direction = \"r\" })") ]; }
        { _args = [ (inline "super .. \"+up\"") (inline "hl.dsp.focus({ direction = \"u\" })") ]; }
        { _args = [ (inline "super .. \"+down\"") (inline "hl.dsp.focus({ direction = \"d\" })") ]; }

        # Workspaces Focus (1 - 10)
        { _args = [ (inline "super .. \"+1\"") (inline "hl.dsp.focus({ workspace = 1 })") ]; }
        { _args = [ (inline "super .. \"+2\"") (inline "hl.dsp.focus({ workspace = 2 })") ]; }
        { _args = [ (inline "super .. \"+3\"") (inline "hl.dsp.focus({ workspace = 3 })") ]; }
        { _args = [ (inline "super .. \"+4\"") (inline "hl.dsp.focus({ workspace = 4 })") ]; }
        { _args = [ (inline "super .. \"+5\"") (inline "hl.dsp.focus({ workspace = 5 })") ]; }
        { _args = [ (inline "super .. \"+6\"") (inline "hl.dsp.focus({ workspace = 6 })") ]; }
        { _args = [ (inline "super .. \"+7\"") (inline "hl.dsp.focus({ workspace = 7 })") ]; }
        { _args = [ (inline "super .. \"+8\"") (inline "hl.dsp.focus({ workspace = 8 })") ]; }
        { _args = [ (inline "super .. \"+9\"") (inline "hl.dsp.focus({ workspace = 9 })") ]; }
        { _args = [ (inline "super .. \"+0\"") (inline "hl.dsp.focus({ workspace = 10 })") ]; }

        # Workspaces Move Window (follow = false)
        { _args = [ (inline "super .. \"+SHIFT+1\"") (inline "hl.dsp.window.move({ workspace = 1, follow = false })") ]; }
        { _args = [ (inline "super .. \"+SHIFT+2\"") (inline "hl.dsp.window.move({ workspace = 2, follow = false })") ]; }
        { _args = [ (inline "super .. \"+SHIFT+3\"") (inline "hl.dsp.window.move({ workspace = 3, follow = false })") ]; }
        { _args = [ (inline "super .. \"+SHIFT+4\"") (inline "hl.dsp.window.move({ workspace = 4, follow = false })") ]; }
        { _args = [ (inline "super .. \"+SHIFT+5\"") (inline "hl.dsp.window.move({ workspace = 5, follow = false })") ]; }
        { _args = [ (inline "super .. \"+SHIFT+6\"") (inline "hl.dsp.window.move({ workspace = 6, follow = false })") ]; }
        { _args = [ (inline "super .. \"+SHIFT+7\"") (inline "hl.dsp.window.move({ workspace = 7, follow = false })") ]; }
        { _args = [ (inline "super .. \"+SHIFT+8\"") (inline "hl.dsp.window.move({ workspace = 8, follow = false })") ]; }
        { _args = [ (inline "super .. \"+SHIFT+9\"") (inline "hl.dsp.window.move({ workspace = 9, follow = false })") ]; }
        { _args = [ (inline "super .. \"+SHIFT+0\"") (inline "hl.dsp.window.move({ workspace = 10, follow = false })") ]; }
        { _args = [ "SUPER + SHIFT + S" (inline "hl.dsp.window.move({ workspace = \"special:special\", follow = false })") ]; }
      ];

      # Window Rules
      window_rule = [
        { match = { title = "^(fetch-float)$"; }; float = true; size = [ 700 700 ]; center = true; }
        { match = { class = "dev.noctalia.Noctalia"; }; float = true; size = [ 1080 920 ]; }
        { match = { title = "^(Open File)(.*)$"; }; center = true; }
        { match = { title = "^(Open File)(.*)$"; }; float = true; }
        { match = { title = "^(Select a File)(.*)$"; }; center = true; }
        { match = { title = "^(Select a File)(.*)$"; }; float = true; }
        { match = { title = "^(Open Folder)(.*)$"; }; center = true; }
        { match = { title = "^(Open Folder)(.*)$"; }; float = true; }
        { match = { title = "^(Save As)(.*)$"; }; center = true; }
        { match = { title = "^(Save As)(.*)$"; }; float = true; }
        { match = { title = "^(Library)(.*)$"; }; center = true; }
        { match = { title = "^(Library)(.*)$"; }; float = true; }
        { match = { title = "^(File Upload)(.*)$"; }; center = true; }
        { match = { title = "^(File Upload)(.*)$"; }; float = true; }
        { match = { title = ".*minecraft.*"; }; immediate = true; }
      ];

      # Workspace Rules
      workspace_rule = {
        workspace = "special:special";
        gaps_out = 30;
      };
    };
  };
}
