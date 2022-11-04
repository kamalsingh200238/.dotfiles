local status_ok, null_ls = pcall(require, "null-ls")
if (not status_ok) then
    print("null-ls not installed")
    return
end

null_ls.setup({
    sources = {
        -- Formaters
        require("null-ls").builtins.formatting.stylua, -- for lua
        require("null-ls").builtins.formatting.prettier, -- for web dev
        -- Linters
        require("null-ls").builtins.diagnostics.eslint,
    },
})
