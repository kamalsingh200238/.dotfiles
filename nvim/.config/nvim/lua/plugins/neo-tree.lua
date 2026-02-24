return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree open" },
    { "<leader>o", "<cmd>Neotree focus<cr>", desc = "NeoTree focus" },
  },
  opts = {
    filesystem = {
      bind_to_cwd = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}
