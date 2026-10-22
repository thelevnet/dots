{ config, lib, ... }:

{
  options.modules.niri = {
    enable = lib.mkEnableOption "Niri desktop environment";
  };

  config = lib.mkIf config.modules.niri.enable {
    wayland.windowManager.niri = {
      enable = true;

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
        };

        prefer-no-csd = { };

        layout = {
          gaps = 10;
          focus-ring.off = { };

          border = {
            width = 2;
            active-color = config.lib.stylix.colors.withHashtag.base09;
            inactive-color = "${config.lib.stylix.colors.withHashtag.base05}33";
          };

          struts = {
            left = 5;
            right = 5;
            top = 5;
            bottom = 5;
          };
        };

        animations = {
          workspace-switch.spring._props = {
            damping-ratio = 1.0;
            stiffness = 1000;
            epsilon = 0.0001;
          };
          horizontal-view-movement.spring._props = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
          window-movement.spring._props = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
          window-resize.spring._props = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
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
          "Home".spawn = [
            "noctalia"
            "msg"
            "panel-toggle"
            "session"
          ];
          "End".spawn = [
            "noctalia"
            "msg"
            "screenshot-fullscreen"
          ];

          "Mod+Return".spawn = [ "kitty" ];
          "Mod+W".spawn = [ "zen" ];
          "Mod+R".spawn = [
            "kitty"
            "rgit"
          ];
          "Mod+X".spawn = [
            "kitty"
            "hx"
          ];
          "Mod+E".spawn = [
            "kitty"
            "superfile"
          ];
          "Mod+T".spawn = [ "Telegram" ];

          "Mod+C".close-window = { };
          "Mod+V".toggle-window-floating = { };
          "Mod+F".fullscreen-window = { };
          "Mod+S".toggle-overview = { };
          "Mod+U".set-column-width = "-25%";
          "Mod+I".set-column-width = "+25%";
          "Mod+O".consume-or-expel-window-left = { };
          "Mod+P".consume-or-expel-window-right = { };
          "Mod+Y".toggle-column-tabbed-display = { };

          "Mod+A".spawn = [
            "noctalia"
            "msg"
            "panel-toggle"
            "control-center"
          ];
          "Mod+Slash".spawn = [
            "noctalia"
            "msg"
            "settings-toggle"
          ];
          "XF86AudioRaiseVolume" = {
            _props.allow-when-locked = true;
            spawn = [
              "noctalia"
              "msg"
              "volume-up"
            ];
          };
          "XF86AudioLowerVolume" = {
            _props.allow-when-locked = true;
            spawn = [
              "noctalia"
              "msg"
              "volume-down"
            ];
          };
          "XF86AudioMute" = {
            _props.allow-when-locked = true;
            spawn = [
              "noctalia"
              "msg"
              "volume-mute"
            ];
          };

          "Mod+H".focus-column-left = { };
          "Mod+L".focus-column-right = { };
          "Mod+K".focus-window-up = { };
          "Mod+J".focus-window-down = { };

          "Mod+Shift+H".move-column-left = { };
          "Mod+Shift+L".move-column-right = { };
          "Mod+Shift+K".move-window-up = { };
          "Mod+Shift+J".move-window-down = { };

          "Page_Down".focus-workspace-down = { };
          "Page_Up".focus-workspace-up = { };
          "Mod+Page_Down".move-column-to-workspace-down = { };
          "Mod+Page_Up".move-column-to-workspace-up = { };
        };

        _children = [
          { spawn-at-startup._args = [ "noctalia" ]; }
          {
            window-rule._children = [
              { match._props.title = "^(Open (File|Folder)|Select a File|Save As|Library|File Upload)"; }
              { open-floating = true; }
            ];
          }
        ];
      };
    };
  };
}
