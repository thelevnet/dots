{ ... }:

let
  commonSettings = {
    fov = 0.5;
    guiScale = 4;
    maxFps = 260;
    renderDistance = 32;
    simulationDistance = 32;
    vsync = false;
  };
in
{
  modules.nite = {
    enable = true;

    instances = {
      default = {
        version = "26.1.2";
        fabric = true;
        username = "levnet";

        mods = [
          "sodium-extra"
          "lithium"
          "iris"
          "modmenu"
          "appleskin"
          "continuity"
          "customskinloader"
          "elytrapitch"
          "ferrite-core"
          "freecam"
          "shulkerboxtooltip"
          "ukus-armor-hud"
          "waylandcraft"
          "sodium"
          "xaeros-world-map"
          "fullbright"
          "lighty"
        ];

        resourcepacks = [
          "fresh-food"
          "fresh-music-discs"
        ];

        shaderpacks = [ "complementary-reimagined" ];

        modsConfig = {
          continuity.json = {
            connected_textures = true;
            emissive_textures = true;
          };

          # Elytra Pitch uses AutoConfig with camelCase fields in config/elytrapitch.json
          elytrapitch.json = {
            ascendAngle = -49;
            descendAngle = 32;
            glideAngle = -2;
            indicatorWidth = 5;
            optimalIndicator = true;
            screenPosition = "BOTTOM_CENTER";
            durabilityPercentage = true;
            durabilityThreshold = 0.05;
            boldMessage = true;
          };

          # Iris reads config/iris.properties with shaderPack and enableShaders
          iris.properties = {
            shaderPack = "ComplementaryReimagined_r5.9.3.zip";
            enableShaders = true;
          };

          # Mod Menu reads config/modmenu.json
          modmenu.json = {
            compact_list = false;
            count_children = true;
            count_libraries = true;
            easter_eggs = true;
            game_menu_button_style = "REPLACE";
            modify_game_menu = true;
            modify_title_screen = true;
            mods_button_style = "CLASSIC";
            quick_configure = true;
            show_libraries = false;
            sorting = "ASCENDING";
            update_checker = true;
          };

          # ukus-armor-hud uses Ukulib with TomlConfigSerializer in config/ukus-armor-hud.toml
          ukus-armor-hud.toml = {
            anchor = "HOTBAR";
            side = "RIGHT";
            style = "HOTBAR";
            orientation = "HORIZONTAL";
            widgetShown = "ALWAYS";
            durabilityDisplay = "BAR";
            iconsShown = true;
            warningShown = true;
            playBreakSound = true;
            minDurabilityValue = 20;
            minDurabilityPercentage = 0.1;
          };
        };

        settings = commonSettings;
      };

      second = {
        version = "26.1.2";
        username = "MihaUA0505";
        settings = commonSettings;
      };
    };
  };
}
