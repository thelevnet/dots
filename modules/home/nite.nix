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
            allow_unknown_shaders = false;
            color_space = "SRGB";
            disable_update_message = false;
            enable_debug_options = false;
            max_shadow_render_distance = 32;
            shader_pack = "ComplementaryUnbound_r5.9.3.zip";
            shaders_enabled = true;
          };
          modmenu = {
            compact_list = false;
            count_children = true;
            count_libraries = true;
            easter_eggs = true;
            game_menu_button_style = "replace";
            modify_game_menu = true;
            modify_title_screen = true;
            mods_button_style = "classic";
            quick_configure = true;
            show_libraries = false;
            sorting = "ascending";
            update_checker = true;
          };
          sodium = {
            animate_only_visible_textures = true;
            chunk_build_defer_mode = "ALWAYS";
            chunk_builder_threads = 0;
            cpu_render_ahead_limit = 3;
            hidden_fluid_culling = true;
            improved_fluid_shaping = false;
            pixel_filtering_mode = "NEAREST";
            use_advanced_staging_buffers = true;
            use_block_face_culling = true;
            use_entity_culling = true;
            use_fog_occlusion = true;
            use_no_error_gl_context = true;
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
          autoJump = false;
          biomeBlendRadius = 2;
          bobView = true;
          cutoutLeaves = true;
          entityDistanceScaling = 0.5;
          entityShadows = true;
          exclusiveFullscreen = true;
          fov = 0.5;
          fullscreen = true;
          gamma = 1.0;
          guiScale = 4;
          inactivityFpsLimit = "afk";
          maxFps = 260;
          mipmapLevels = 0;
          mouseSensitivity = 0.50176;
          particles = 0;
          prioritizeChunkUpdates = 1;
          rawMouseInput = true;
          reducedDebugInfo = false;
          renderDistance = 32;
          showAutosaveIndicator = false;
          simulationDistance = 32;
          syncChunkWrites = false;
          vsync = false;
        };
      }
      {
        name = "toni";
        version = "26.1.2";
        username = "toni";
      }
      {
        name = "sepher";
        version = "26.1.2";
        username = "sepher";
      }
    ];
  };
}
