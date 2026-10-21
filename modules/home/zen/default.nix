{ config, pkgs, lib, ... }:

let
  cfg = config.modules.zen;
  profileDir = "zen/i7ey1six.Default Profile";
in
{
  options.modules.zen = {
    enable = lib.mkEnableOption "Zen Browser configuration";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      # Zen profile registration
      "zen/profiles.ini".text = ''
        [Profile0]
        Name=Default Profile
        IsRelative=1
        Path=i7ey1six.Default Profile
        Default=1

        [General]
        StartWithLastProfile=1
        Version=2
      '';

      # Declarative preferences synced with your profile
      "${profileDir}/user.js".text = ''
        // Enable custom userChrome & devtools
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        user_pref("devtools.chrome.enabled", true);

        // Disable gradients & transparency
        user_pref("zen.theme.gradient", false);
        user_pref("browser.tabs.allow_transparent_browser", false);
        user_pref("zen.widget.linux.transparency", false);
        user_pref("zen.theme.acrylic-elements", false);

        // Zen layout & compact mode
        user_pref("zen.view.compact.hide-toolbar", true);
        user_pref("zen.view.sidebar-expanded", false);
        user_pref("zen.view.use-single-toolbar", false);
        user_pref("zen.tabs.select-recently-used-on-close", false);
        user_pref("zen.workspaces.separate-essentials", false);
        user_pref("zen.welcome-screen.seen", true);

        // Better Ctrl+Tab switcher styling
        user_pref("psu.better_ctrltab.background", "light-dark(rgba(144, 144, 144, 0.94), rgba(22, 22, 22, 0.92))");
        user_pref("psu.better_ctrltab.padding", "16px");
        user_pref("psu.better_ctrltab.preview_border_color", "light-dark(rgba(255, 255, 255, 0.1), rgba(1, 1, 1, 0.1))");
        user_pref("psu.better_ctrltab.preview_border_width", "1px");
        user_pref("psu.better_ctrltab.preview_favicon_outdent", "12px");
        user_pref("psu.better_ctrltab.preview_favicon_size", "36px");
        user_pref("psu.better_ctrltab.preview_focus_background", "light-dark(rgba(77, 77, 77, 0.8), rgba(204, 204, 204, 0.33))");
        user_pref("psu.better_ctrltab.preview_font_size", "13px");
        user_pref("psu.better_ctrltab.roundness", "0px");
        user_pref("psu.better_ctrltab.shadow_size", "0px");
        user_pref("psu.better_ctrltab.zoom", "0.8");
      '';

      # Custom stylesheets
      "${profileDir}/chrome/userChrome.css".source = ./userChrome.css;
      "${profileDir}/chrome/userContent.css".source = ./userContent.css;

      # Custom keyboard shortcuts
      "${profileDir}/zen-keyboard-shortcuts.json".source = ./zen-keyboard-shortcuts.json;
    };
  };
}
