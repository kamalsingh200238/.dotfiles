return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },

  { "rose-pine/neovim", event = "VeryLazy" },
  { "catppuccin/nvim", event = "VeryLazy" },
  { "EdenEast/nightfox.nvim", event = "VeryLazy" },
  { "sainnhe/gruvbox-material", event = "VeryLazy" },
  { "olimorris/onedarkpro.nvim", event = "VeryLazy" },
  { "folke/tokyonight.nvim", event = "VeryLazy" },
  { "tiagovla/tokyodark.nvim", event = "VeryLazy" },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<leader>st", mode = { "n", "x" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  { "tpope/vim-fugitive", event = "VeryLazy" },

  { "mattn/emmet-vim", event = "VeryLazy" },

  { "nvim-pack/nvim-spectre", event = "VeryLazy", opts = {} },

  { "echasnovski/mini.surround", event = "VeryLazy", opts = {} },

  { "jose-elias-alvarez/typescript.nvim" },
  -- { "sigmasd/deno-nvim" },

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
}
