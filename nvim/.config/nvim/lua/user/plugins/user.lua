return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  { "rose-pine/neovim", event = "VeryLazy" },
  { "catppuccin/nvim", event = "VeryLazy" },
  { "EdenEast/nightfox.nvim", event = "VeryLazy" },
  { "sainnhe/gruvbox-material", event = "VeryLazy" },
  { "LunarVim/horizon.nvim", event = "VeryLazy" },
  { "olimorris/onedarkpro.nvim", event = "VeryLazy" },
  { "tiagovla/tokyodark.nvim", event = "VeryLazy" },
  { "haishanh/night-owl.vim", event = "VeryLazy" },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    event = "VeryLazy",
    opts = {},
  },

  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
}
