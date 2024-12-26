return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>qs", false },
      { "<leader>qS", false },
      { "<leader>ql", false },
      { "<leader>qd", false },
      { "<leader>ps", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>pS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>pd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      local actions = require("fzf-lua.actions")

      return {
        files = {
          actions = {
            ["alt-i"] = nil,
            ["alt-h"] = nil,
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ["ctrl-h"] = { actions.toggle_hidden },
            ["alt-i"] = nil,
            ["alt-h"] = nil,
          },
        },
      }
    end,
  },
}
