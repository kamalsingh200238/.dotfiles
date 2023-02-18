require("mason.settings").set({
  ui = {
    border = "rounded",
  },
})

local lsp = require("lsp-zero")

lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = false,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = false,
  call_servers = "local",
  sign_icons = {
    error = "✘",
    warn = "▲",
    hint = "⚑",
    info = "",
  },
})

lsp.ensure_installed({
  "tsserver",
  "tailwindcss",
  "lua_ls",
})

lsp.on_attach(function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover documentaion" }, bufopts)
  vim.keymap.set("n", "gd", "<Cmd>Telescope lsp_definitions<Cr>", { desc = "goto definition" }, bufopts)
  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "goto declaration" }, bufopts)
  vim.keymap.set("n", "gT", "<Cmd>Telescope lsp_type_definitions<Cr>", { desc = "goto type_definition" }, bufopts)
  vim.keymap.set("n", "gi", "<Cmd>Telescope lsp_implementations<Cr>", { desc = "goto implementation" }, bufopts)
  -- vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", { desc = "goto peek_definition" }, bufopts)
  vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<Cr>", { desc = "goto references" }, bufopts)
  -- vim.keymap.set("n", "gl", "<Cmd>Lspsaga lsp_finder<CR>", { desc = "lspsaga lsp finder" }, bufopts)

  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "traditional rename by lsp" }, bufopts)
  vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.signature_help() end, { desc = "lsp signature" }, bufopts)
  vim.keymap.set("n", "<space>lc", function() vim.lsp.buf.code_action() end, { desc = "code actions by lsp" }, bufopts)
  vim.keymap.set("n", "<space>lf", function() vim.lsp.buf.format({ async = true }) end, { desc = "format code" }, bufopts)

  -- workspace
  vim.keymap.set("n", "<space>lwa", function() vim.lsp.buf.add_workspace_folder() end, { desc = "add workspace" }, bufopts)
  vim.keymap.set("n", "<space>lwr", function() vim.lsp.buf.remove_workspace_folder() end, { desc = "remove workspace" }, bufopts)
  vim.keymap.set("n", "<space>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = "list all workspace" }, bufopts)

  -- diagnostics
  vim.keymap.set("n", "<leader>df", function() vim.diagnostic.open_float() end, { desc = "hover diagnostic" }, bufopts)
  -- vim.keymap.set("n", "[l", "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = "line diagnostics lspsaga" }, bufopts)
  -- vim.keymap.set("n", "[c", "<cmd>Lspsaga show_cursor_diagnostics<cr>", { desc = "cursor diagnostics lspsaga" }, bufopts)
end)

lsp.configure("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
