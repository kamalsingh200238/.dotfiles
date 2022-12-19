local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
	print("cmp not installed")
	return
end
if vim.g.snippets ~= "luasnip" then
	print("set vim.g.snippets = 'luasnip'")
	return
end
require("luasnip.loaders.from_vscode").lazy_load()
local options = {
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = true,

	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	updateevents = "TextChanged,TextChangedI",

	-- Autosnippets:
	enable_autosnippets = true,
}

--mappings
vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { desc = "expand/jump-forward in a snippet" }, { silent = true })

-- vim.keymap.set({ "i", "s" }, "<C-j>", function()
-- 	if ls.jumpable(1) then
-- 		ls.jump(-1)
-- 	end
-- end, { desc = "jump backward in snippet" }, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { desc = "jump backward in snippet" }, { silent = true })

vim.keymap.set("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { desc = "select from list of options in a snippet" })

ls.snippets = {
-- all = {
-- 	ls.parser.parse_snippet("expand", "--this will be expanded"),
-- },
}

ls.config.set_config(options)
