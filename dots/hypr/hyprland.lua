--------------
---- vars ----
local super = "SUPER"
local ipc = "noctalia msg "

-------------------
---- autostart ----
-------------------
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
	hl.exec_cmd("kitty")
	hl.exec_cmd("noctalia")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
	hl.exec_cmd("systemctl --user start graphical-session.target")
end)

------------------
---- keybinds ----
------------------
-- System & Panel Controls --
hl.bind(super .. "+Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(super .. "+A", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(super .. "+Slash", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd(ipc .. "panel-toggle session"))

-- Window Management & Layouts --
hl.bind(super .. "+C", hl.dsp.window.close())
hl.bind(super .. "+V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(super .. "+D", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(super .. "+F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(super .. "+ALT+F", hl.dsp.window.fullscreen_state({ internal = 0, client = 3, action = "toggle" }))
hl.bind(super .. "+S", hl.dsp.workspace.toggle_special("special"))
hl.bind(super .. "+Semicolon", hl.dsp.layout("splitratio -0.1"))
hl.bind(super .. "+Apostrophe", hl.dsp.layout("splitratio +0.1"))
hl.bind(super .. "+Backslash", hl.dsp.window.resize({ x = 1200, y = 800, "exact" }))
hl.bind(super .. "+O", hl.dsp.exec_cmd("kitty --title fetch-float -- fetch --size 15.0 --no-info --infinite -s 2.0"))

-- Apps --
hl.bind(super .. "+Return", hl.dsp.exec_cmd("kitty"))
hl.bind(super .. "+E", hl.dsp.exec_cmd("kitty yazi"))
hl.bind(super .. "+W", hl.dsp.exec_cmd("firefox"))
hl.bind(super .. "+X", hl.dsp.exec_cmd("kitty nvim"))
hl.bind(super .. "+Q", hl.dsp.exec_cmd("Telegram"))

-- Mouse Bindings --
hl.bind(super .. "+mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(super .. "+mouse:274", hl.dsp.window.drag(), { mouse = true })
hl.bind(super .. "+mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media & Hardware Keys --
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

-- Directional Focus --
hl.bind(super .. "+left", hl.dsp.focus({ direction = "l" }))
hl.bind(super .. "+right", hl.dsp.focus({ direction = "r" }))
hl.bind(super .. "+up", hl.dsp.focus({ direction = "u" }))
hl.bind(super .. "+down", hl.dsp.focus({ direction = "d" }))

-- Workspace: Focus --
hl.bind(super .. "+1", hl.dsp.focus({ workspace = 1 }))
hl.bind(super .. "+2", hl.dsp.focus({ workspace = 2 }))
hl.bind(super .. "+3", hl.dsp.focus({ workspace = 3 }))
hl.bind(super .. "+4", hl.dsp.focus({ workspace = 4 }))
hl.bind(super .. "+5", hl.dsp.focus({ workspace = 5 }))
hl.bind(super .. "+6", hl.dsp.focus({ workspace = 6 }))
hl.bind(super .. "+7", hl.dsp.focus({ workspace = 7 }))
hl.bind(super .. "+8", hl.dsp.focus({ workspace = 8 }))
hl.bind(super .. "+9", hl.dsp.focus({ workspace = 9 }))
hl.bind(super .. "+0", hl.dsp.focus({ workspace = 10 }))

-- Workspace: Move Window --
hl.bind(super .. "+SHIFT+1", hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind(super .. "+SHIFT+2", hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind(super .. "+SHIFT+3", hl.dsp.window.move({ workspace = 3, follow = false }))
hl.bind(super .. "+SHIFT+4", hl.dsp.window.move({ workspace = 4, follow = false }))
hl.bind(super .. "+SHIFT+5", hl.dsp.window.move({ workspace = 5, follow = false }))
hl.bind(super .. "+SHIFT+6", hl.dsp.window.move({ workspace = 6, follow = false }))
hl.bind(super .. "+SHIFT+7", hl.dsp.window.move({ workspace = 7, follow = false }))
hl.bind(super .. "+SHIFT+8", hl.dsp.window.move({ workspace = 8, follow = false }))
hl.bind(super .. "+SHIFT+9", hl.dsp.window.move({ workspace = 9, follow = false }))
hl.bind(super .. "+SHIFT+0", hl.dsp.window.move({ workspace = 10, follow = false }))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:special", follow = false }))

-----------------
---- general ----
-----------------
hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
})

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@144",
	position = "1920x0",
	scale = 1,
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.config({
	gestures = {
		workspace_swipe_distance = 700,
		workspace_swipe_cancel_ratio = 0.2,
		workspace_swipe_min_speed_to_force = 5,
		workspace_swipe_direction_lock = true,
		workspace_swipe_direction_lock_threshold = 10,
		workspace_swipe_create_new = true,
	},
	general = {
		gaps_in = 5,
		gaps_out = 10,
		gaps_workspaces = 50,

		border_size = 0,
		no_focus_fallback = true,
		allow_tearing = true, -- This just allows the `immediate` window rule to work
		snap = {
			enabled = true,
			window_gap = 4,
			monitor_gap = 5,
			respect_gaps = true,
		},
	},
	decoration = {
		rounding_power = 2,
		rounding = 20,

		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		},
		-- Dim
		dim_inactive = true,
		dim_strength = 0.05,
		dim_special = 0.2,
	},
	animations = {
		enabled = true,
	},
	dwindle = {
		preserve_split = true,
		smart_split = false,
		smart_resizing = false,
		-- precise_mouse_move = true,
	},
})

----------------
---- Curves ----
----------------
hl.curve("expressiveFastSpatial", { type = "bezier", points = { { 0.42, 1.67 }, { 0.21, 0.90 } } })
hl.curve("expressiveSlowSpatial", { type = "bezier", points = { { 0.39, 1.29 }, { 0.35, 0.98 } } })
hl.curve("expressiveDefaultSpatial", { type = "bezier", points = { { 0.38, 1.21 }, { 0.22, 1.00 } } })
hl.curve("emphasizedDecel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("emphasizedAccel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("standardDecel", { type = "bezier", points = { { 0, 0 }, { 0, 1 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.52, 0.03 }, { 0.72, 0.08 } } })
hl.curve("stall", { type = "bezier", points = { { 1, -0.1 }, { 0.7, 0.85 } } })
-----------------
---- Configs ----
-----------------
-- windows
hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 3,
	bezier = "emphasizedDecel",
	style = "popin 80%",
})
hl.animation({
	leaf = "fadeIn",
	enabled = true,
	speed = 3,
	bezier = "emphasizedDecel",
})
hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 2,
	bezier = "emphasizedDecel",
	style = "popin 90%",
})
hl.animation({
	leaf = "fadeOut",
	enabled = true,
	speed = 2,
	bezier = "emphasizedDecel",
})
hl.animation({
	leaf = "windowsMove",
	enabled = true,
	speed = 3,
	bezier = "emphasizedDecel",
	style = "slide",
})
hl.animation({
	leaf = "border",
	enabled = true,
	speed = 10,
	bezier = "emphasizedDecel",
})

-- layers
hl.animation({
	leaf = "layersIn",
	enabled = true,
	speed = 2.7,
	bezier = "emphasizedDecel",
	style = "popin 93%",
})
hl.animation({
	leaf = "layersOut",
	enabled = true,
	speed = 2.4,
	bezier = "menu_accel",
	style = "popin 94%",
})
-- fade
hl.animation({
	leaf = "fadeLayersIn",
	enabled = true,
	speed = 0.5,
	bezier = "menu_decel",
})
hl.animation({
	leaf = "fadeLayersOut",
	enabled = true,
	speed = 2.7,
	bezier = "stall",
})
-- workspaces
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 7,
	bezier = "menu_decel",
	style = "slide",
})
-- specialWorkspace
hl.animation({
	leaf = "specialWorkspaceIn",
	enabled = true,
	speed = 2.8,
	bezier = "emphasizedDecel",
	style = "slidevert",
})
hl.animation({
	leaf = "specialWorkspaceOut",
	enabled = true,
	speed = 1.2,
	bezier = "emphasizedAccel",
	style = "slidevert",
})

hl.config({
	input = {
		kb_layout = "us,ru",
		kb_options = "grp:caps_toggle",
		numlock_by_default = true,
		repeat_delay = 250,
		repeat_rate = 35,

		follow_mouse = 1,
		off_window_axis_events = 2,

		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
			clickfinger_behavior = true,
			scroll_factor = 0.7,
		},
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 0,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		animate_manual_resizes = false,
		animate_mouse_windowdragging = false,
		enable_swallow = false,
		swallow_regex = "(foot|kitty|allacritty|Alacritty)",
		on_focus_under_fullscreen = 2,
		allow_session_lock_restore = true,
		session_lock_xray = true,
		initial_workspace_tracking = false,
		focus_on_activate = true,
	},

	binds = {
		scroll_event_delay = 0,
		hide_special_on_workspace_change = true,
	},

	cursor = {
		zoom_factor = 1,
		zoom_rigid = false,
		zoom_disable_aa = true,
		hotspot_padding = 1,
	},

	xwayland = {
		force_zero_scaling = true,
	},
})
hl.window_rule({ match = { title = "^(fetch-float)$" }, float = true, size = { 700, 700 }, center = true })
hl.window_rule({ match = { class = "dev.noctalia.Noctalia" }, float = true, size = { 1080, 920 } })
hl.window_rule({ match = { title = "^(Open File)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(Open File)(.*)$" }, float = true })
hl.window_rule({ match = { title = "^(Select a File)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(Select a File)(.*)$" }, float = true })
hl.window_rule({ match = { title = "^(Open Folder)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(Open Folder)(.*)$" }, float = true })
hl.window_rule({ match = { title = "^(Save As)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(Save As)(.*)$" }, float = true })
hl.window_rule({ match = { title = "^(Library)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(Library)(.*)$" }, float = true })
hl.window_rule({ match = { title = "^(File Upload)(.*)$" }, center = true })
hl.window_rule({ match = { title = "^(File Upload)(.*)$" }, float = true })
hl.window_rule({ match = { title = ".*minecraft.*" }, immediate = true })
hl.workspace_rule({ workspace = "special:special", gaps_out = 30 })
