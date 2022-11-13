local o = vim.opt
local g = vim.g

vim.cmd("autocmd!")
vim.scriptencoding = "utf-8"
vim.wo.number = true

o.encoding = "utf-8"
o.fileencoding = "utf-8"

g.snippets = "luasnip" -- for snippets
o.number = true
o.relativenumber = true
o.signcolumn = "yes" -- for space on left hand side
o.timeoutlen = 500

o.title = true

-- indent
o.autoindent = true
o.smartindent = true
o.breakindent = true

-- tab
o.smarttab = true
o.shiftwidth = 2
o.tabstop = 2

o.formatoptions = "cro"
o.hlsearch = true
o.backup = false
o.showcmd = true
o.cmdheight = 1
o.laststatus = 2
o.expandtab = true
o.scrolloff = 8
o.backupskip = { "/tmp/*", "/private/tmp/*" }
o.inccommand = "split"
o.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
o.wrap = false -- No Wrap lines
o.backspace = { "start", "eol", "indent" }
o.path:append({ "**" }) -- Finding files - Search down into subfolders
o.wildignore:append({ "*/node_modules/*" })

-- For Colors
o.cursorline = true
o.termguicolors = true
o.winblend = 0
o.wildoptions = "pum"
o.pumblend = 5
o.background = "dark"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Add asterisks in block comments
o.formatoptions:append({ "r" })
