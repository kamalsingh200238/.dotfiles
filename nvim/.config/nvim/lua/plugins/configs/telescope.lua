local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	print("telescope not installed")
	return
end

-- For telescope
local builtin = require("telescope.builtin")
local opts = { silent = true, noremap = true }
vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, opts)
vim.keymap.set("n", "<leader>ft", builtin.colorscheme, opts)
vim.keymap.set("n", "<leader>gc", builtin.git_commits, opts)
vim.keymap.set("n", "<leader>gb", builtin.git_branches, opts)

telescope.setup({
	defaults = {
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		layout_config = {
			horizontal = {
				preview_width = 0.5,
				results_width = 0.5,
			},
			width = 0.99,
			height = 0.99,
			preview_cutoff = 120,
		},
		file_ignore_patterns = { "node_modules" },
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
	},
})
