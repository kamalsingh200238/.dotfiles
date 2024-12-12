local wezterm = require("wezterm")
return {
	-- color_scheme
	color_scheme = "Catppuccin Mocha",

	-- font
	font = wezterm.font_with_fallback({
		{ family = "JetBrains Mono", weight = "Bold" },
		{ family = "Symbols Nerd Font", scale = 0.90 },
		{ family = "JoyPixels" },
	}),
	font_size = 12.0,
	line_height = 1.0,

	-- Window
	window_close_confirmation = "NeverPrompt",
	window_background_opacity = 1,
	window_padding = { -- For padding
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	force_reverse_video_cursor = true,

	-- Tabs
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = false,
	tab_max_width = 2,
	window_frame = {
		font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
		font_size = 8.0,
		active_titlebar_bg = "#222222",
	},
}
