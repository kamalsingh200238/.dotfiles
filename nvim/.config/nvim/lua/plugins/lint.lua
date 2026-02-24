return {
  "mfussenegger/nvim-lint",
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", '{"MD013":false,"MD031":false}' },
      },
    },
  },
}
