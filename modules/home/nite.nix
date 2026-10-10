{ config, pkgs, inputs, ... }:

{
  modules.nite = {
    enable = true;

    instances = [
      {
        name = "default";
        version = "26.1.2";
        fabric = true;
        username = "levnet";
        
        mods = [
          "sodium-extra" "lithium" "iris" "patpat" "modmenu" "appleskin"
          "continuity" "customskinloader" "elytrapitch" "ferrite-core"
          "legacyfreecam" "shulkerboxtooltip" "ukus-armor-hud" "waylandcraft"
          "sodium"
        ];
        
        resourcepacks = [ "fresh-food" "fresh-music-discs" "mattpack" ];
        shaderpacks = [ "complementary-unbound" ];

        modsConfig = {
          continuity = {
            connected_textures = true;
            emissive_textures = true;
          };
          elytrapitch = {
            ascend_angle = -45;
            bold_message = true;
            descend_angle = 45;
            durability_percentage = true;
            durability_threshold = 0.05;
            glide_angle = 0;
            indicator_width = 5;
            optimal_indicator = true;
            screen_position = "BOTTOM_CENTER";
          };
          iris = {
            shader_pack = "ComplementaryUnbound_r5.9.3.zip";
            shaders_enabled = true;
          };
          ukus-armor-hud = {
            anchor = "HOTBAR";
            durability_display = "BAR";
            enabled = true;
            icons_shown = true;
            min_durability_percentage = 0.1;
            min_durability_value = 20;
            offset_x = 0;
            offset_y = 0;
            orientation = "HORIZONTAL";
            play_break_sound = true;
            side = "RIGHT";
            style = "HOTBAR";
            warning_shown = true;
            widget_shown = "ALWAYS";
          };
        };

        settings = {
          advancedItemTooltips = true;
          fov = 0.5;
          guiScale = 4;
          inactivityFpsLimit = "afk";
          maxFps = 260;
          renderDistance = 32;
          simulationDistance = 32;
          vsync = false;
        };
      }
      {
        name = "optimization";
        version = "26.3";
        username = "levnet";

        settings = {
          fov = 0.5;
          guiScale = 4;
          inactivityFpsLimit = "afk";
          maxFps = 260;
          renderDistance = 32;
          simulationDistance = 32;
          vsync = false;
        };
      }
    ];
  };
}
