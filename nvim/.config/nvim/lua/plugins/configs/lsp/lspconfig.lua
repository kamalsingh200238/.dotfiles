local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	print("lspconfig not installed")
	return
end

-- For capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- to remove conflict with server provided formating
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- goto
	vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", { desc = "Hover documentaion" }, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "goto definition" }, bufopts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "goto declaration" }, bufopts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "goto type_definition" }, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "goto implementation" }, bufopts)
	vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", { desc = "goto peek_definition" }, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "goto references" }, bufopts)

	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "traditional rename by lsp" }, bufopts)
	vim.keymap.set("n", "<leader>lr", "<Cmd>Lspsaga rename<CR>", { desc = "rename by lspsaga" }, bufopts)
	vim.keymap.set("n", "<leader>ll", "<Cmd>Lspsaga lsp_finder<CR>", { desc = "lspsaga lsp finder" }, bufopts)
	vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "lsp signature" }, bufopts)
	vim.keymap.set("n", "<space>lc", vim.lsp.buf.code_action, { desc = "code actions by lsp" }, bufopts)
	vim.keymap.set("n", "<space>la", "<cmd>Lspsaga range_code_actions<cr>", { desc = "code actions by lsp" }, bufopts)
	vim.keymap.set("n", "<space>lf", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "format code" }, bufopts)

	-- workspace
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace" }, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace" }, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { desc = "list all workspace" }, bufopts)

	-- diagnostics
	vim.keymap.set(
		"n",
		"<space>dl",
		"<cmd>Lspsaga show_line_diagnostics<cr>",
		{ desc = "line diagnostics lspsaga" },
		bufopts
	)
	vim.keymap.set(
		"n",
		"<space>dc",
		"<cmd>Lspsaga show_cursor_diagnostics<cr>",
		{ desc = "cursor diagnostics lspsaga" },
		bufopts
	)
end

-- Typescript server
lspconfig.tsserver.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Lua server
lspconfig.sumneko_lua.setup({
	capabilities = capabilities,
	on_attach = on_attach,
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

-- emmet server
lspconfig.emmet_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
