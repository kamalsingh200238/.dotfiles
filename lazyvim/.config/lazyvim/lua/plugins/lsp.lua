return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      local sources = {
        "clangd",
        "prettierd",
        "htmlhint",
      }
      for _, value in ipairs(sources) do
        table.insert(opts.ensure_installed, value)
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = { init_options = { provideFormatter = false } },
        cssls = { init_options = { provideFormatter = false } },
        emmet_ls = {},
        templ = {},
      },
    },
  },
}
