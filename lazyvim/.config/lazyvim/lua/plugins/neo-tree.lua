return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree open" },
    { "<leader>o", "<cmd>Neotree focus<cr>", desc = "NeoTree focus" },
  },
  opts = {
    filesystem = {
      bind_to_cwd = true,
      follow_current_file = { enabled = false },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}
