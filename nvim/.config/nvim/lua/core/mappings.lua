local map = vim.keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "

-- Insert Mode
map.set("i", "jk", "<Esc>", { desc = "" }, opts)

-- Normal mode
map.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "", expr = true })
map.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "", expr = true })
map.set("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "", expr = true })
map.set("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "", expr = true })

map.set("n", "<leader>q", "<cmd>q<Cr>", { desc = "quit" }, opts)
map.set("n", "<C-q>", "<cmd>q!<Cr>", { desc = "force quit" }, opts)
map.set("n", "<leader>w", "<cmd>w<Cr>", { desc = "save file" }, opts)

map.set("n", "<ESC>", "<cmd>noh<Cr>", { desc = "remove search highligting" }, opts)

map.set("n", "+", "<C-a>", { desc = "increase count" }, opts)
map.set("n", "-", "<C-x>", { desc = "decrease count" }, opts)

map.set("n", "<C-a>", "gg<S-v>G", { desc = "select whole document" }, opts)

map.set("n", "<leader><leader>s", "<cmd>source %<cr>", { desc = "source current file" }, opts)

-- for better copy and paste
map.set("n", "<leader>y", '"+y', { desc = "copy in clipboard" }, opts)
map.set("v", "<leader>y", '"+y', { desc = "copy in clipboard" }, opts)

-- Split Window
map.set("n", "ss", ":split<Return><C-w>w", { desc = "split window horizontally" })
map.set("n", "sv", ":vsplit<Return><C-w>w", { desc = "split vertically" }, opts)

-- Move window
map.set("n", "<C-h>", function()
	require("smart-splits").move_cursor_left()
end, { desc = "change panel to left" }, opts)
map.set("n", "<C-l>", function()
	require("smart-splits").move_cursor_right()
end, { desc = "change panel to right" }, opts)
map.set("n", "<C-j>", function()
	require("smart-splits").move_cursor_down()
end, { desc = "change panel to up" }, opts)
map.set("n", "<C-k>", function()
	require("smart-splits").move_cursor_up()
end, { desc = "change panel to down" }, opts)
map.set("n", "H", function()
	require("smart-splits").move_cursor_left()
end, { desc = "change panel to left" }, opts)
map.set("n", "L", function()
	require("smart-splits").move_cursor_right()
end, { desc = "change panel to right" }, opts)
map.set("n", "J", function()
	require("smart-splits").move_cursor_down()
end, { desc = "change panel to up" }, opts)
map.set("n", "K", function()
	require("smart-splits").move_cursor_up()
end, { desc = "change panel to down" }, opts)
-- map.set('n', '<Space>', '<C-w>w',opts)
-- map.set("n", "<C-h>", "<C-w>h", { desc = "change panel to left" }, opts)
-- map.set("n", "<C-l>", "<C-w>l", { desc = "change panel to right" }, opts)
-- map.set("n", "<C-j>", "<C-w>j", { desc = "change panel to up" }, opts)
-- map.set("n", "<C-k>", "<C-w>k", { desc = "change panel to down" }, opts)
-- map.set("n", "H", "<C-w>h", { desc = "change panel to left" }, opts)
-- map.set("n", "L", "<C-w>l", { desc = "change panel to right" }, opts)
-- map.set("n", "J", "<C-w>j", { desc = "change panel to up" }, opts)
-- map.set("n", "K", "<C-w>k", { desc = "change panel to down" }, opts)

-- Resize window
map.set("n", "<C-up>", function()
	require("smart-splits").resize_up()
end, { desc = "resize window" }, opts)
map.set("n", "<C-down>", function()
	require("smart-splits").resize_down()
end, { desc = "resize window" }, opts)
map.set("n", "<C-left>", function()
	require("smart-splits").resize_left()
end, { desc = "resize window" }, opts)
map.set("n", "<C-right>", function()
	require("smart-splits").resize_right()
end, { desc = "resize window" }, opts)

-- Packer
map.set("n", "<leader>ps", "<cmd>PackerSync<Cr>", { desc = "packer sync" }, opts)
map.set("n", "<leader>pS", "<cmd>PackerStatus<Cr>", { desc = "packer status" }, opts)
map.set("n", "<leader>pc", "<cmd>PackerCompile<Cr>", { desc = "packer compile" }, opts)
map.set("n", "<leader>pC", "<cmd>PackerClean<Cr>", { desc = "packer clean" }, opts)

-- For buffers
map.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" }, opts)
map.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous Buffer" }, opts)
map.set("n", "<leader>x", "<Cmd>bd<Cr>", { desc = "close buffer" }, opts)

-- For Nvim tree
map.set("n", "<leader>e", "<cmd>NvimTreeToggle<Cr>", { desc = "Toggle Nvim tree" }, opts)
map.set("n", "<leader>o", "<cmd>NvimTreeFocus<Cr>", { desc = "Focus Nvim tree" }, opts)

-- Diagnostics
map.set("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "jump prev diagonstic" }, opts)
map.set("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "jump next diagonstic" }, opts)

-- For telescope
map.set("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, { desc = "Search files" }, opts)

map.set("n", "<leader>fF", function()
	require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
end, { desc = "Search all files" }, opts)

map.set("n", "<leader>fw", function()
	require("telescope.builtin").live_grep()
end, { desc = "Search words" }, opts)

map.set("n", "<leader>fW", function()
	require("telescope.builtin").live_grep({
		additional_args = function(args)
			return vim.list_extend(args, { "--hidden", "--no-ignore" })
		end,
	})
end, { desc = "Search words in all files" }, opts)

map.set("n", "<leader>gs", function()
	require("telescope.builtin").git_status()
end, { desc = "Git status" }, opts)

map.set("n", "<leader>gb", function()
	require("telescope.builtin").git_branches()
end, { desc = "Git branches" }, opts)

map.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, { desc = "search buffers" }, opts)

map.set("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end, { desc = "Search help" }, opts)

map.set("n", "<leader>fm", function()
	require("telescope.builtin").marks()
end, { desc = "Search marks" }, opts)

map.set("n", "<leader>fo", function()
	require("telescope.builtin").oldfiles()
end, { desc = "Search history" }, opts)

map.set("n", "<leader>fc", function()
	require("telescope.builtin").grep_string()
end, { desc = "Search for word under cursor" }, opts)

map.set("n", "<leader>fM", function()
	require("telescope.builtin").man_pages()
end, { desc = "Search man" }, opts)

map.set("n", "<leader>fr", function()
	require("telescope.builtin").registers()
end, { desc = "Search registers" }, opts)

map.set("n", "<leader>fk", function()
	require("telescope.builtin").keymaps()
end, { desc = "Search keymaps" }, opts)

map.set("n", "<leader>fC", function()
	require("telescope.builtin").commands()
end, { desc = "Search commands" }, opts)

map.set("n", "<leader>fd", function()
	require("telescope.builtin").diagnostics()
end, { desc = "Search diagnostics" }, opts)
