return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.filesystem.filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false
      -- hide_hidden = false, -- only works on Windows for hidden files/directories
    }
    -- opts.window.position = "right"
    return opts
  end,
}
