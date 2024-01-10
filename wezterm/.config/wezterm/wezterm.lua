local wezterm = require("wezterm")
return {
	-- color_scheme
	color_scheme = "Aci (Gogh)",
	-- color_scheme = "Atelier Sulphurpool (base16)",
	-- color_scheme = "AtelierSulphurpool",
	-- color_scheme = "Aura (Gogh)",
	-- color_scheme = "AyuDark (Gogh)",

	-- font
	-- font = wezterm.font("JetBrains Mono Nerd Font", { weight = "Medium" }),
	font = wezterm.font_with_fallback({
		{ family = "JetBrains Mono", weight = "Bold" },
		{ family = "Symbols Nerd Font", scale = 0.75 },
		{ family = "JoyPixels" },
	}),
	font_size = 14.6,
	line_height = 1.0,

	-- Window
	-- window_decorations = "RESIZE",
	window_close_confirmation = "NeverPrompt",
	window_background_opacity = 1,
	window_padding = { -- For padding
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	force_reverse_video_cursor = true,
	-- cursor_fg = "rgba(0,0,0,0)",

	-- Tabs
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = false,
	tab_max_width = 2,
	window_frame = {
		font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
		font_size = 10.0,
		active_titlebar_bg = "#222222",
		inactive_titlebar_bg = "#333333",
	},
}
