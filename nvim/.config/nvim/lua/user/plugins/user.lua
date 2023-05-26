return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  { "rose-pine/neovim", event = "VeryLazy" },
  { "catppuccin/nvim", event = "VeryLazy" },
  { "EdenEast/nightfox.nvim", event = "VeryLazy" },
  { "sainnhe/gruvbox-material", event = "VeryLazy" },
  { "olimorris/onedarkpro.nvim", event = "VeryLazy" },
  { "rktjmp/lush.nvim", event = "VeryLazy" },
  { dir = "~/projects/colorschemes/", event = "VeryLazy" },
  -- { "notken12/base46-colors", event = "VeryLazy" },
  {
    "phaazon/hop.nvim",
    event = "VeryLazy",
    branch = "v2",
    opts = {},
  },
  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "mattn/emmet-vim", event = "VeryLazy" },
  { "nvim-pack/nvim-spectre", event = "VeryLazy", opts = {} },
  { "echasnovski/mini.surround", event = "VeryLazy", opts = {} },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
}
