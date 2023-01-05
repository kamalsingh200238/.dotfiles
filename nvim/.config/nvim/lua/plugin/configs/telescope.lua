local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	print("telescope not installed")
	return
end

telescope.setup({
	defaults = {
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		layout_config = {
			horizontal = {
				preview_width = 0.4,
				results_width = 0.6,
			},
			width = 0.85,
			height = 0.85,
			preview_cutoff = 120,
		},
		file_ignore_patterns = { "node_modules" },
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
	},
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
	},
})
