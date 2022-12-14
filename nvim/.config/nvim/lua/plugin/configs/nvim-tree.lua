local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
  print("nvim tree not installed")
  return
end
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    side = "right",
    width = 30,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  -- renderer = {
  -- 	add_trailing = true,
  -- 	indent_markers = {
  -- 		enable = true,
  -- 		icons = {
  -- 			corner = "└",
  -- 			edge = "│",
  -- 			item = "│",
  -- 			bottom = "─",
  -- 			none = " ",
  -- 		},
  -- 	},
  -- },
})
