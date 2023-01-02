local status_ok, ts = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	print("tree sitter not installed")
end

ts.setup({
	ensure_installed = {},
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = true,
	-- Automatically install missing parsers when entering buffer
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
	},
	-- Colored brackets
	rainbow = {
		enable = true,
		extended_mode = false,
		colors = {
			"#ebb434",
			"#14fc03",
			"#21baed",
			"#ffffff",
			"#862dfc",
		},
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		config = {
			javascript = {
				__default = "// %s",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = "// %s",
				comment = "// %s",
			},
		},
	},
})
