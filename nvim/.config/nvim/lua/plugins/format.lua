return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cpp = { "clang-format" },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        less = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        templ = { "templ" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
