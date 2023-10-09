return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    local actions = require "telescope.actions"
    opts.defaults.mappings.i = {
      ["<C-j>"] = actions.cycle_history_next,
      ["<C-k>"] = actions.cycle_history_prev,
      ["<C-n>"] = actions.move_selection_next,
      ["<C-p>"] = actions.move_selection_previous,
    }
    return opts
  end,
}
