{ config, lib, ... }:

{
  options.modules.noctalia = {
    enable = lib.mkEnableOption "Noctalia desktop shell";
  };

  config = lib.mkIf config.modules.noctalia.enable {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
    };

    xdg.configFile = {
      "noctalia/config.toml".text = ''
[audio]
enable_sounds = false

[bar]
order = [ "left" ]

    [bar.left]
    capsule = true
    capsule_padding = 14.0
    capsule_thickness = 0.76000000000000001
    end = [ "audio_visualizer", "group:g1", "session" ]
    font_weight = 1000
    layer = "top"
    margin_ends = 0
    padding = 10
    panel_overlap = 0
    position = "left"
    radius = 30
    radius_bottom_left = 0
    radius_top_left = 0
    reserve_space = true
    start = [ "group:g2", "workspaces" ]
    thickness = 58

        [bar.left.dead_zone.actions]
        right = "none"

        [[bar.left.capsule_group]]
        accordion = false
        accordion_direction = "end"
        enabled = true
        fill = "surface_variant"
        id = "g1"
        members = [ "bluetooth", "network" ]
        opacity = 1.0
        padding = 14.0

        [[bar.left.capsule_group]]
        accordion = false
        accordion_direction = "end"
        enabled = true
        fill = "surface_variant"
        id = "g2"
        members = [ "launcher", "control-center", "notes_2" ]
        opacity = 1.0
        padding = 14.0

[calendar]

[control_center]
show_shortcut_labels = false
width = 720

    [control_center.calendar]
    show_events_card = false
    show_week_numbers = true

    [[control_center.shortcuts]]
    type = "wifi"

    [[control_center.shortcuts]]
    type = "bluetooth"

    [[control_center.shortcuts]]
    type = "caffeine"

    [[control_center.shortcuts]]
    type = "system"

    [[control_center.shortcuts]]
    type = "keyboard_layout"

    [[control_center.shortcuts]]
    type = "nightlight"

[desktop_widgets]
schema_version = 2
widget_order = [ "desktop-widget-000000000000000a", "desktop-widget-000000000000000b" ]

    [desktop_widgets.grid]
    cell_size = 32
    major_interval = 4
    visible = true

    [desktop_widgets.widget.desktop-widget-000000000000000a]
    box_height = 288.0
    box_width = 1792.0
    cx = 960.0
    cy = 928.5
    output = "eDP-1"
    placement_height = 0.0
    placement_width = 0.0
    rotation = 0.0
    type = "audio_visualizer"

        [desktop_widgets.widget.desktop-widget-000000000000000a.settings]
        background = false
        bands = 24
        centered = false
        color_1 = "primary"
        color_2 = "primary"
        mirrored = true
        show_when_idle = false

    [desktop_widgets.widget.desktop-widget-000000000000000b]
    box_height = 736.0
    box_width = 2528.0
    cx = 1280.0
    cy = 1072.0
    output = "DP-1"
    placement_height = 1440.0
    placement_width = 2560.0
    rotation = 0.0
    type = "audio_visualizer"

        [desktop_widgets.widget.desktop-widget-000000000000000b.settings]
        background = false
        bands = 44
        centered = false
        color_1 = "primary"
        color_2 = "primary"
        mirrored = true
        reversed = false
        show_when_idle = false

[dock]
auto_hide = false
border = "primary"
border_width = 0.0
inactive_opacity = 1.0
inactive_scale = 1.0
layer = "overlay"
magnification_scale = 2.0
margin_edge = 0
pinned = [ "zen", "org.telegram.desktop", "kitty" ]
position = "right"
radius = 58
reserve_space = false
shadow = false
show_dots = true
show_instance_count = false
smart_auto_hide = true

[hot_corners]
delay_ms = 300

    [hot_corners.bottom_left]
    action = "launcher"

    [hot_corners.bottom_right]
    action = "window_switcher"

[location]
address = "Eitorf, Germany"

[lockscreen]
tint_intensity = 0.0

[lockscreen_widgets]
enabled = true
schema_version = 2
widget_order = [
    "lockscreen-login-box@FALLBACK",
    "lockscreen-login-box@WAYLAND-1",
    "lockscreen-login-box@DP-1",
    "lockscreen-login-box@eDP-1",
    "lockscreen-widget-0000000000000003"
]

    [lockscreen_widgets.grid]
    cell_size = 16
    major_interval = 4
    visible = true

    [lockscreen_widgets.widget."lockscreen-login-box@DP-1"]
    box_height = 196.0
    box_width = 810.0
    cx = 1280.0
    cy = 1258.0
    output = "DP-1"
    placement_height = 1440.0
    placement_width = 2560.0
    rotation = 0.0
    type = "login_box"

        [lockscreen_widgets.widget."lockscreen-login-box@DP-1".settings]
        background_color = "surface_variant"
        background_opacity = 0.88
        background_radius = 12.0
        center_password_text = false
        input_opacity = 1.0
        input_radius = 6.0
        layout = "regular"
        show_caps_lock = true
        show_keyboard_layout = true
        show_login_button = true
        show_media = true
        show_session_buttons = true
        show_unlock_hint = true
        show_weather = true

    [lockscreen_widgets.widget."lockscreen-login-box@FALLBACK"]
    box_height = 196.0
    box_width = 810.0
    cx = 960.0
    cy = 898.0
    output = "FALLBACK"
    placement_height = 1080.0
    placement_width = 1920.0
    rotation = 0.0
    type = "login_box"

        [lockscreen_widgets.widget."lockscreen-login-box@FALLBACK".settings]
        background_color = "surface_variant"
        background_opacity = 0.88
        background_radius = 12.0
        center_password_text = false
        input_opacity = 1.0
        input_radius = 6.0
        layout = "regular"
        show_caps_lock = true
        show_keyboard_layout = true
        show_login_button = true
        show_media = true
        show_session_buttons = true
        show_unlock_hint = true
        show_weather = true

    [lockscreen_widgets.widget."lockscreen-login-box@WAYLAND-1"]
    box_height = 196.0
    box_width = 720.0
    cx = 603.99969482421875
    cy = 1237.9996337890625
    output = "WAYLAND-1"
    placement_height = 1420.0
    placement_width = 1207.0
    rotation = 0.0
    type = "login_box"

        [lockscreen_widgets.widget."lockscreen-login-box@WAYLAND-1".settings]
        background_color = "surface_variant"
        background_opacity = 0.88
        background_radius = 12.0
        center_password_text = false
        input_opacity = 1.0
        input_radius = 6.0
        layout = "regular"
        show_caps_lock = true
        show_keyboard_layout = true
        show_login_button = true
        show_media = true
        show_session_buttons = true
        show_unlock_hint = true
        show_weather = true

    [lockscreen_widgets.widget."lockscreen-login-box@eDP-1"]
    box_height = 82.0
    box_width = 720.0
    cx = 944.0
    cy = 1027.0
    output = "eDP-1"
    placement_height = 0.0
    placement_width = 0.0
    rotation = 0.0
    type = "login_box"

        [lockscreen_widgets.widget."lockscreen-login-box@eDP-1".settings]
        background_color = "surface_variant"
        background_opacity = 0.0
        background_radius = 0.0
        center_password_text = false
        input_opacity = 1.0
        input_radius = 32.0
        layout = "regular"
        show_caps_lock = true
        show_keyboard_layout = true
        show_login_button = false
        show_media = false
        show_session_buttons = false
        show_unlock_hint = false
        show_weather = false

    [lockscreen_widgets.widget.lockscreen-widget-0000000000000003]
    box_height = 240.0
    box_width = 656.0
    cx = 944.0
    cy = 868.0
    output = "eDP-1"
    placement_height = 0.0
    placement_width = 0.0
    rotation = 0.0
    type = "clock"

        [lockscreen_widgets.widget.lockscreen-widget-0000000000000003.settings]
        background = true
        background_color = "on_primary"
        background_opacity = 1.0
        background_padding = 0
        background_radius = 32
        center_text = true
        clock_style = "digital"
        color = "primary"
        font_family = "Google Sans Flex"
        format = "{:%H:%M:%S}"
        shadow = false

[notification]
history_retention_hours = 24
layer = "overlay"
scale = 1.2

[osd]
background_opacity = 0.99999997764825821
offset_y = 200
position = "bottom_center"
scale = 1.2000000104308128

[plugin_settings."nightwatch75/todo"]
panel_open_near_click = false

[plugin_settings."noctalia/notes"]
panel_open_near_click = true
panel_placement = "attached"

[plugin_settings."samuelskovbakke/calculator-plus"]
panel_layer = "overlay"
panel_open_near_click = false
panel_placement = "floating"
panel_position = "center"

[plugin_settings."yocraft/qrcode"]
generate_button = false
size = 100
titlebar = false

[plugins]
auto_update = "all"
enabled = [ "noctalia/notes" ]

[shell]
app_icon_color = "primary"
avatar_path = "/home/lev/Pictures/hole.png"
button_borders = false
card_borders = false
corner_radius_scale = 1.5000000223517418
font_family = "Google Sans Flex"
input_borders = false
niri_overview_type_to_launch_enabled = true
popup_borders = false
popup_shadows = false
screen_time_enabled = true

    [shell.keyboard_layout.custom_labels]
    "English (US)" = "en"
    Russian = "ru"

    [shell.launcher]
    categories = false
    fetch_exchange_rates = false
    sort_by_usage = false

        [shell.launcher.providers.calculator]
        global = false

    [shell.panel]
    open_near_click_clipboard = true
    open_near_click_session = true
    session_placement = "floating"
    session_position = "center"
    shadow = true
    wallpaper_placement = "floating"
    wallpaper_position = "center"

    [shell.screen_corners]
    enabled = true
    size = 30

    [shell.screenshot]
    annotate = true
    confirm_region = true
    remember_last_region = true
    save_to_file = false
    show_cursor = true

    [shell.session]
    grid = true
    grid_columns = 1
    show_shortcuts = false

        [[shell.session.actions]]
        action = "lock"
        countdown_seconds = 0.0
        enabled = true
        shortcut = "1"
        variant = "default"

        [[shell.session.actions]]
        action = "logout"
        countdown_seconds = 0.0
        enabled = true
        shortcut = "2"
        variant = "default"

        [[shell.session.actions]]
        action = "lock_and_suspend"
        countdown_seconds = 0.0
        enabled = false
        shortcut = "3"
        variant = "default"

        [[shell.session.actions]]
        action = "reboot"
        countdown_seconds = 0.0
        enabled = false
        shortcut = "4"
        variant = "default"

        [[shell.session.actions]]
        action = "shutdown"
        countdown_seconds = 0.0
        enabled = true
        shortcut = "5"
        variant = "destructive"

[theme]
builtin = "Ayu"
community_palette = "Tomorrow"
custom_palette = "torii-ts"
mode = "dark"
source = "wallpaper"
wallpaper_scheme = "m3-tonal-spot"

    [theme.templates]
    builtin_ids = [ "kitty", "niri", "starship" ]
    community_ids = [ "antigravity", "zen-browser", "telegram", "fastfetch", "bat", "yazi" ]

        [theme.templates.user.kitty]
        enabled = true
        input_path = "templates/kitty.conf"
        output_path = "$XDG_CACHE_HOME/noctalia/kitty-theme.conf"
        post_hook = "pkill -f -USR1 kitty"

        [theme.templates.user.neovim]
        enabled = true
        input_path = "templates/neovim.lua"
        output_path = "$XDG_CACHE_HOME/noctalia/matugen.lua"
        post_hook = "pkill -f -SIGUSR1 nvim"

        [theme.templates.user.telegram]
        enabled = true
        input_path = "templates/telegram.tdesktop-theme"
        output_path = "$XDG_CACHE_HOME/noctalia/telegram/colors.tdesktop-theme"
        post_hook = "kitty +runpy \"import runpy; runpy.run_path('$HOME/.config/noctalia/scripts/pack-telegram.py')\""

[wallpaper]
transition = [ "stripes" ]
transition_on_startup = true

    [wallpaper.automation]
    enabled = true
    interval_seconds = 300

    [wallpaper.default]
    path = "/home/lev/Pictures/city.png"

    [wallpaper.last]
    path = "/home/lev/Pictures/city.png"

    [wallpaper.monitors.DP-1]
    path = "/home/lev/Pictures/city.png"

    [wallpaper.monitors.eDP-1]
    path = "/home/lev/Pictures/Wallpapers/torii.jpg"

[widget.audio_visualizer]
bands = 20
scale = 1.5
show_when_idle = true
width = 85

[widget.battery]
display_mode = "none"
scale = 1.5

[widget.bluetooth]
scale = 1.5

[widget.caffeine]
scale = 1.5

[widget.clipboard]
scale = 1.5

[widget.clock]
color = "primary"
scale = 1.7

    [widget.clock.actions]
    left = "panel-toggle control-center home"

[widget.control-center]
color = "primary"
enabled = false
glyph = "home"
scale = 1.5

[widget.keyboard_layout]
scale = 1.5
show_glyph = false

[widget.launcher]
color = "primary"
scale = 1.5

[widget.media]
artist_first = true
hide_album_art = true
hide_when_no_media = true
max_length = 200
min_length = 0

[widget.network]
scale = 1.5
show_label = false

[widget.notes_2]
scale = 1.5
type = "noctalia/notes:notes"

[widget.power_profile]
scale = 1.5

[widget.privacy]
hide_inactive = true

[widget.screenshot]
glyph = "border-corners"
scale = 1.5

[widget.session]
color = "primary"
scale = 1.5

[widget.settings]
scale = 1.5

    [widget.settings.actions]
    left = "settings-toggle"

[widget.volume]
scale = 1.5
show_label = false

[widget.workspaces]
active_pill_size = 2.0
label_source = "name"
labels_only_when_occupied = true
scale = 1.5
scroll_repeat = "steps"
urgent_color = "secondary"
      '';

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
  };
}
