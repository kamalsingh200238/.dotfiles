local status_ok, null_ls = pcall(require, "null-ls")
if (not status_ok) then
  print("null-ls not installed")
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
null_ls.setup({
  sources = {
    -- Formaters
    formatting.stylua, -- for lua
    formatting.prettier, -- for web dev
    formatting.latexindent, -- for web dev
    -- diagnostics
    diagnostics.eslint,
    -- code actions
  },
})
