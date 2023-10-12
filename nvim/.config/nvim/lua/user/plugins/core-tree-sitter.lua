return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = {
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "json5",
      "lua",
      "python",
      "htmldjango",
      "go",
    }

    -- Install parsers synchronously (only applied to `ensure_installed`)
    opts.sync_install = true

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    opts.auto_install = true

    return opts
  end,
}
