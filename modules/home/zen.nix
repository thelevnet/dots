{ config, lib, ... }:

let
  cfg = config.modules.zen;
  c = config.lib.stylix.colors.withHashtag;
  profileDir = "zen/i7ey1six.Default Profile";
in
{
  options.modules.zen = {
    enable = lib.mkEnableOption "Zen Browser configuration";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
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

      "${profileDir}/user.js".text = ''
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        user_pref("zen.theme.gradient", false);
        user_pref("browser.tabs.allow_transparent_browser", false);
        user_pref("zen.widget.linux.transparency", false);
        user_pref("zen.theme.acrylic-elements", false);
      '';

      "${profileDir}/chrome/userChrome.css".text = ''
        :root {
          --zen-primary-color: ${c.base09} !important;
          --zen-colors-primary: ${c.base00} !important;
          --zen-colors-secondary: ${c.base01} !important;
          --zen-colors-tertiary: ${c.base02} !important;
          --zen-colors-border: ${c.base03} !important;
          --zen-main-browser-background: ${c.base00} !important;
          --zen-themed-toolbar-bg: ${c.base00} !important;
          --zen-urlbar-background: ${c.base01} !important;
          --zen-colors-input-bg: ${c.base01} !important;

          --zen-theme-gradient: none !important;
          --zen-theme-gradient-secondary: none !important;

          --toolbar-bgcolor: ${c.base00} !important;
          --toolbar-field-background-color: ${c.base01} !important;
          --toolbar-field-color: ${c.base05} !important;
          --toolbar-field-focus-background-color: ${c.base02} !important;
          --toolbar-field-focus-color: ${c.base05} !important;
          --toolbar-color: ${c.base05} !important;
          --lwt-text-color: ${c.base05} !important;
          --arrowpanel-background: ${c.base02} !important;
          --arrowpanel-color: ${c.base05} !important;
          --arrowpanel-border-color: ${c.base03} !important;
        }

        #navigator-toolbox,
        #TabsToolbar,
        #titlebar,
        #zen-tabbox-wrapper,
        #zen-appcontent-navbar-container,
        #zen-sidebar-top-buttons,
        #zen-sidebar-icons-wrapper,
        #zen-current-workspace-indicator,
        .tabbrowser-tab,
        .tab-background,
        .tab-stack,
        #urlbar,
        #urlbar-background,
        #zen-workspaces-button,
        #zen-sidebar-splitter,
        toolbar,
        toolbarbutton {
          background-image: none !important;
        }

        *,
        *::before,
        *::after {
          border-radius: 0 !important;
          font-family: "JetBrains Mono", monospace !important;
        }
      '';

      "${profileDir}/chrome/userContent.css".text = ''
        @-moz-document url-prefix("about:"), url-prefix("chrome://") {
          :root {
            --in-content-page-background: ${c.base00} !important;
            --in-content-page-color: ${c.base05} !important;
            --in-content-text-color: ${c.base05} !important;
            --in-content-box-background: ${c.base01} !important;
            --in-content-box-border-color: ${c.base03} !important;
            --in-content-border-color: ${c.base03} !important;
            --in-content-primary-button-background: ${c.base09} !important;
            --in-content-primary-button-text-color: ${c.base00} !important;
            --color-accent-primary: ${c.base09} !important;
            --link-color: ${c.base0B} !important;
          }
        }

        *,
        *::before,
        *::after {
          border-radius: 0 !important;
        }

        *:not([class*="icon"]):not([class*="fa"]):not([class*="material"]):not([class*="octicon"]):not([class*="glyph"]):not(i) {
          font-family: "JetBrains Mono", monospace !important;
        }

        ::selection {
          background-color: ${c.base09} !important;
          color: ${c.base00} !important;
        }
      '';
    };
  };
}
