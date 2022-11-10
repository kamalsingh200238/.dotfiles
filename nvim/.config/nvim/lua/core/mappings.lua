local map = vim.keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "

-- Insert Mode
map.set("i", "jk", "<Esc>", { desc = "" }, opts)

-- Normal mode
map.set("n", "<leader>q", "<cmd>q<Cr>", { desc = "quit" }, opts)
map.set("n", "<C-q>", "<cmd>q!<Cr>", { desc = "force quit" }, opts)
map.set("n", "<leader>s", "<cmd>w<Cr>", { desc = "save file" }, opts)
map.set("n", "<leader>h", "<cmd>nohlsearch<Cr>", { desc = "remove search highligting" }, opts)
map.set("n", "+", "<C-a>", { desc = "increase count" }, opts)
map.set("n", "-", "<C-x>", { desc = "decrease count" }, opts)
map.set("n", "<C-a>", "gg<S-v>G", { desc = "select whole document" }, opts)
map.set("n", "<leader><leader>s", "<cmd>source %<cr>", { desc = "source current file" }, opts)

-- Split Window
map.set("n", "ss", ":split<Return><C-w>w", { desc = "split window horizontally" })
map.set("n", "sv", ":vsplit<Return><C-w>w", { desc = "split vertically" }, opts)

-- Move window
-- map.set('n', '<Space>', '<C-w>w',opts)
map.set("n", "<C-h>", "<C-w>h", { desc = "change panel to left" }, opts)
map.set("n", "<C-l>", "<C-w>l", { desc = "change panel to right" }, opts)
map.set("n", "<C-j>", "<C-w>j", { desc = "change panel to up" }, opts)
map.set("n", "<C-k>", "<C-w>k", { desc = "change panel to down" }, opts)
-- Resize window
map.set("n", "<C-right>", "<C-w><", { desc = "resize window" }, { noremap = true, silent = true, buffer = 0 })
map.set("n", "<C-left>", "<C-w>>", { desc = "resize window" }, { noremap = true, silent = true, buffer = 0 })
map.set("n", "<C-up>", "<C-w>+", { desc = "resize window" }, { noremap = true, silent = true, buffer = 0 })
map.set("n", "<C-down>", "<C-w>-", { desc = "resize window" }, { noremap = true, silent = true, buffer = 0 })
-- Packer
map.set("n", "<leader>pc", "<cmd>PackerCompile<Cr>", { desc = "packer compile" }, opts)
map.set("n", "<leader>ps", "<cmd>PackerSync<Cr>", { desc = "packer sync" }, opts)
map.set("n", "<leader>pC", "<cmd>PackerClean<Cr>", { desc = "packer clean" }, opts)

-- Better copy paste
map.set({ "n", "v" }, "<leader>y", '"+y', { desc = "copy in clipboard" }, opts)
map.set({ "n", "v" }, "<leader>x", '"+d', { desc = "cut in clipboard" }, opts)
map.set({ "n", "v" }, "<leader>p", '"+p', { desc = "paste from clipboard" }, opts)

-- For buffers
map.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" }, opts)
map.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous Buffer" }, opts)

-- For Nvim tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<Cr>", { desc = "Toggle Nvim tree" }, opts)
vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeFocus<Cr>", { desc = "Focus Nvim tree" }, opts)

-- Diagnostics
vim.keymap.set("n", "<leader>dk", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "jump prev diagonstic" }, opts)
vim.keymap.set("n", "<leader>dj", "<Cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "jump next diagonstic" }, opts)
