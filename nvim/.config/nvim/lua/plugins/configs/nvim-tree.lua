local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
	print("nvim tree not installed")
	return
end
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- OR setup with some options
nvimtree.setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = false,
		side = "right",
		width = 30,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
	},
	filters = {
		dotfiles = true,
	},
})
