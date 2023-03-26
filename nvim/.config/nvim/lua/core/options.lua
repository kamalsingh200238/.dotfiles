local o = vim.opt
local g = vim.g

-- encoding
vim.scriptencoding = "utf-8"
o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.backspace = vim.opt.backspace + { "nostop" }
o.cmdheight = 1
o.completeopt = { "menu", "menuone", "noselect" }
o.cursorline = true
-- tab
o.expandtab = true
o.smarttab = true
o.shiftwidth = 2
o.tabstop = 2
-- indent
o.copyindent = true -- Copy the previous indentation on autoindenting
o.autoindent = true
o.smartindent = true
o.breakindent = true
o.number = true
o.relativenumber = true
o.signcolumn = "yes" -- for space on left hand side
o.timeoutlen = 500
o.scrolloff = 8
o.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor
o.hlsearch = true
o.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
o.smartcase = true
o.undofile = true -- Enable persistent undo
o.backup = false
o.writebackup = false -- Disable making a backup before overwriting a file
o.wrap = false -- No Wrap lines
o.laststatus = 3 -- globalstatus
o.pumheight = 10 -- Height of the pop up menu
-- For Colors
o.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
o.termguicolors = true
o.background = "dark"
o.linebreak=true -- when set wrap will not break the work in middle

g.snippets = "luasnip" -- for snippets
g.highlighturl_enabled = true -- highlight URLs by default
g.mapleader= " "

if vim.g.neovide then
  vim.o.guifont = "JetBrains Mono:h14" -- text below applies for VimScript
end
