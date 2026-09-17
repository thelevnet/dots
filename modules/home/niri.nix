{ config, lib, pkgs, ... }:

{
  options.modules.niri = {
    enable = lib.mkEnableOption "Niri desktop environment";
  };

  config = lib.mkIf config.modules.niri.enable {
    xdg.configFile."niri/config.kdl".force = true;

    wayland.windowManager.niri = {
      enable = true;
      package = pkgs.niri;
      checkConfig = false; 

      settings = {
        input = {
          keyboard = {
            xkb = {
              layout = "us,ru";
              options = "grp:caps_toggle";
            };
            repeat-delay = 250;
            repeat-rate = 35;
            numlock = { };
          };

          touchpad = {
            tap = { };
            natural-scroll = { };
            click-method = "clickfinger";
            scroll-factor = 0.7;
          };

          focus-follows-mouse = { };
          workspace-auto-back-and-forth = { };
        };

        cursor = {
          xcursor-theme = "Bibata-Modern-Classic";
          xcursor-size = 24;
        };

        environment = {
          XCURSOR_THEME = "Bibata-Modern-Classic";
          XCURSOR_SIZE = "24";
        };

        prefer-no-csd = { };

        layout = {
          gaps = 10;
          center-focused-column = "never";

          preset-column-widths._children = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
          ];

          default-column-width.proportion = 0.5;

          focus-ring = {
            width = 2;
            inactive-color = "#00000000";
          };

          border.off = { };

          shadow = {
            on = { };
            softness = 30;
            spread = 5;
            offset._props = { x = 0; y = 5; };
            color = "#0007";
          };

          struts = {
            left = 5;
            right = 5;
            top = 5;
            bottom = 5;
          };
        };

        animations = {
          workspace-switch.spring._props = { damping-ratio = 1.0; stiffness = 1000; epsilon = 0.0001; };
          horizontal-view-movement.spring._props = { damping-ratio = 1.0; stiffness = 800; epsilon = 0.0001; };
          window-movement.spring._props = { damping-ratio = 1.0; stiffness = 800; epsilon = 0.0001; };
          window-resize.spring._props = { damping-ratio = 1.0; stiffness = 800; epsilon = 0.0001; };
          window-open = {
            duration-ms = 150;
            curve = "ease-out-expo";
          };
          window-close = {
            duration-ms = 150;
            curve = "ease-out-quad";
          };
        };

        binds = {
          "Mod+Space".spawn = [ "noctalia" "msg" "panel-toggle" "control-center" ];
          "Mod+Slash".spawn = [ "noctalia" "msg" "settings-toggle" ];
          "Ctrl+Alt+Delete".spawn = [ "noctalia" "msg" "panel-toggle" "session" ];
          "Print".spawn-sh = [ "noctalia msg screenshot-fullscreen; notify-send 'Screenshot'" ];

          "Home".spawn-sh = [ "kitty --title fetch-float -- fetch --size 15.0 --no-info --infinite -s 2.0" ];
          "Mod+Return".spawn = [ "kitty" ];
          "Mod+E".spawn = [ "kitty" "yazi" ];
          "Mod+W".spawn = [ "zen" ];
          "Mod+X".spawn = [ "kitty" "nvim" ];
          "Mod+Q".spawn = [ "Telegram" ];

          "Mod+C".close-window = { };
          "Mod+V".toggle-window-floating = { };
          "Mod+D".maximize-column = { };
          "Mod+F".fullscreen-window = { };
          "Mod+S".toggle-overview = { };
          "Mod+Semicolon".set-column-width = "-50%";
          "Mod+Apostrophe".set-column-width = "+50%";
          "Mod+Comma".consume-window-into-column = { };
          "Mod+Period".expel-window-from-column = { };
          "Mod+Tab".toggle-column-tabbed-display = { };

          "XF86AudioRaiseVolume" = {
            _props.allow-when-locked = true;
            spawn = [ "noctalia" "msg" "volume-up" ];
          };
          "XF86AudioLowerVolume" = {
            _props.allow-when-locked = true;
            spawn = [ "noctalia" "msg" "volume-down" ];
          };
          "XF86AudioMute" = {
            _props.allow-when-locked = true;
            spawn = [ "noctalia" "msg" "volume-mute" ];
          };
          "XF86MonBrightnessUp" = {
            _props.allow-when-locked = true;
            spawn = [ "noctalia" "msg" "brightness-up" ];
          };
          "XF86MonBrightnessDown" = {
            _props.allow-when-locked = true;
            spawn = [ "noctalia" "msg" "brightness-down" ];
          };

          "Mod+Left".focus-column-left = { };
          "Mod+Right".focus-column-right = { };
          "Mod+Up".focus-window-up = { };
          "Mod+Down".focus-window-down = { };
          "Mod+H".focus-column-left = { };
          "Mod+L".focus-column-right = { };
          "Mod+K".focus-window-up = { };
          "Mod+J".focus-window-down = { };

          "Mod+Ctrl+Left".move-column-left = { };
          "Mod+Ctrl+Right".move-column-right = { };
          "Mod+Ctrl+Up".move-window-up = { };
          "Mod+Ctrl+Down".move-window-down = { };
          "Mod+Ctrl+H".move-column-left = { };
          "Mod+Ctrl+L".move-column-right = { };
          "Mod+Ctrl+K".move-window-up = { };
          "Mod+Ctrl+J".move-window-down = { };

          "Mod+Page_Down".focus-workspace-down = { };
          "Mod+Page_Up".focus-workspace-up = { };
          "Mod+Ctrl+Page_Down".move-column-to-workspace-down = { };
          "Mod+Ctrl+Page_Up".move-column-to-workspace-up = { };
          "Mod+Shift+Page_Down".move-workspace-down = { };
          "Mod+Shift+Page_Up".move-workspace-up = { };

          "Mod+WheelScrollDown" = {
            _props.cooldown-ms = 150;
            focus-workspace-down = { };
          };
          "Mod+WheelScrollUp" = {
            _props.cooldown-ms = 150;
            focus-workspace-up = { };
          };
          "Mod+Ctrl+WheelScrollDown" = {
            _props.cooldown-ms = 150;
            move-column-to-workspace-down = { };
          };
          "Mod+Ctrl+WheelScrollUp" = {
            _props.cooldown-ms = 150;
            move-column-to-workspace-up = { };
          };
        };

        _children = [
          {
            output = {
              _args = [ "DP-1" ];
              mode = "2560x1440@179.952";
              scale = 1.0;
              variable-refresh-rate = { };
            };
          }
          {
            output = {
              _args = [ "eDP-1" ];
              scale = 1.0;
              variable-refresh-rate = { };
            };
          }

          {
            spawn-sh-at-startup._args = [
              "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE; dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE; systemctl --user start graphical-session.target"
            ];
          }
          { spawn-at-startup._args = [ "noctalia" ]; }
          { spawn-at-startup._args = [ "xwayland-satellite" ]; }

          {
            window-rule._children = [
              { geometry-corner-radius = 20; }
              { clip-to-geometry = true; }
            ];
          }
          {
            window-rule._children = [
              { match._props.title = "^fetch-float$"; }
              { open-floating = true; }
              { default-column-width.fixed = 700; }
              { default-window-height.fixed = 700; }
            ];
          }
          {
            window-rule._children = [
              { match._props.app-id = "^dev\\.noctalia\\.Noctalia$"; }
              { open-floating = true; }
              { default-column-width.fixed = 1080; }
              { default-window-height.fixed = 920; }
            ];
          }
          {
            window-rule._children = [
              { match._props.title = "^Open File"; }
              { match._props.title = "^Select a File"; }
              { match._props.title = "^Open Folder"; }
              { match._props.title = "^Save As"; }
              { match._props.title = "^Library"; }
              { match._props.title = "^File Upload"; }
              { open-floating = true; }
            ];
          }
          {
            window-rule._children = [
              { match._props.title = ".*minecraft.*"; }
              { variable-refresh-rate = true; }
            ];
          }
        ];
      };

      extraConfig = ''
        include "${config.xdg.configHome}/niri/noctalia.kdl"
      '';
    };
  };
}
