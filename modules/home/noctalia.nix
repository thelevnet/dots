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
pinned = [ "zen", "org.telegram.desktop" ]
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
    builtin_ids = [ "kitty", "niri" ]
    community_ids = [ "antigravity", "zen-browser", "telegram", "fastfetch", "bat", "yazi" ]

        [theme.templates.user.neovim]
        enabled = true
        input_path = "templates/neovim.lua"
        output_path = "$XDG_CACHE_HOME/noctalia/matugen.lua"
        post_hook = "pkill -f -SIGUSR1 nvim"


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
  };
  };
}
