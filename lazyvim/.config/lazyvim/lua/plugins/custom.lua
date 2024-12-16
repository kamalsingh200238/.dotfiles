return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      -- disable keymaps
      keys[#keys + 1] = { "<leader>cl", false }
      keys[#keys + 1] = { "<leader>ca", false }
      keys[#keys + 1] = { "<leader>cc", false }
      keys[#keys + 1] = { "<leader>cC", false }
      keys[#keys + 1] = { "<leader>cR", false }
      keys[#keys + 1] = { "<leader>cr", false }
      keys[#keys + 1] = { "<leader>cA", false }

      -- add keymaps
      keys[#keys + 1] = { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" }
      keys[#keys + 1] =
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" }
      keys[#keys + 1] =
        { "<leader>lc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" }
      keys[#keys + 1] = {
        "<leader>lC",
        vim.lsp.codelens.refresh,
        desc = "Refresh & Display Codelens",
        mode = { "n" },
        has = "codeLens",
      }
      keys[#keys + 1] = {
        "<leader>lR",
        function()
          Snacks.rename.rename_file()
        end,
        desc = "Rename File",
        mode = { "n" },
        has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
      }
      keys[#keys + 1] = { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
      keys[#keys + 1] = { "<leader>lA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" }
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>o", "<cmd>Neotree focus<cr>", desc = "NeoTree focus" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>,", false },
      { "<leader>/", false },
      { "<leader>:", false },
      { "<leader><space>", false },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },
}
