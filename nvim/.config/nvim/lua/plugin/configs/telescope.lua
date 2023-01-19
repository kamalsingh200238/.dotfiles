local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  print("telescope not installed")
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "top",
      width = 0.80,
      height = 0.99,
      horizontal = {
        preview_width = 0.4,
        results_width = 0.6,
      },
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
  mappings = {
    i = {
      ["<C-j>"] = actions.cycle_history_next,
      ["<C-k>"] = actions.cycle_history_prev,
    },
    n = { ["q"] = actions.close },
  },
})
