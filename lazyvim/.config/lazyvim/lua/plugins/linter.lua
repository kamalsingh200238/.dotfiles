return {
  "mfussenegger/nvim-lint",
  opts = {
    linters = {
      sqlfluff = {
        args = {
          "lint",
          "--format=json",
        },
      },
      ["markdownlint-cli2"] = {
        args = { "--config", '{"MD013":false,"MD031":false}' },
      },
    },
  },
}
