return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      local sources = {
        "clang-format",
        "clangd",
        "css-lsp",
        "emmet-ls",
        "html-lsp",
        "prettierd",
        "templ",
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
        cssls = { init_options = { provideFormatter = false } },
        html = { init_options = { provideFormatter = false } },
      },
    },
  },
}
