return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  {
    "p00f/alabaster.nvim",
  },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end,
  },
}
