local map = vim.keymap.set
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "

map("n", "j", 'v:count || mode(2)[0:1] == "no" ? "j" : "gj"', { desc = "", expr = true, silent = true })
map("n", "k", 'v:count || mode(2)[0:1] == "no" ? "k" : "gk"', { desc = "", expr = true, silent = true })
map("n", "<Up>", 'v:count || mode(2)[0:1] == "no" ? "k" : "gk"', { desc = "", expr = true, silent = true })
map("n", "<Down>", 'v:count || mode(2)[0:1] == "no" ? "j" : "gj"', { desc = "", expr = true, silent = true })

-- quit and save
map("n", "<leader>q", "<cmd>q<Cr>", { desc = "quit" }, opts)
map("n", "<C-q>", "<cmd>q!<Cr>", { desc = "force quit" }, opts)
map("n", "<leader>w", "<cmd>w<Cr>", { desc = "save file" }, opts)

map("n", "<ESC>", "<cmd>noh<Cr>", { desc = "remove search highligting" }, opts)
map("n", "+", "<C-a>", { desc = "increase count" }, opts)
map("n", "-", "<C-x>", { desc = "decrease count" }, opts)
map("n", "<C-a>", "gg<S-v>G", { desc = "select whole document" }, opts)
map("n", "<leader><leader>s", "<cmd>source %<cr>", { desc = "source current file" }, opts)
-- for better copy and paste
map({ "n", "v" }, "<leader>y", '"+y', { desc = "copy in clipboard" }, opts)

-- Split Window
map("n", "ss", ":split<Return><C-w>w", { desc = "split window horizontally" })
map("n", "sv", ":vsplit<Return><C-w>w", { desc = "split vertically" }, opts)

-- Move window
map("n", "<C-h>", function() require("smart-splits").move_cursor_left() end, { desc = "change panel to left" }, opts)
map("n", "<C-l>", function() require("smart-splits").move_cursor_right() end, { desc = "change panel to right" }, opts)
map("n", "<C-j>", function() require("smart-splits").move_cursor_down() end, { desc = "change panel to up" }, opts)
map("n", "<C-k>", function() require("smart-splits").move_cursor_up() end, { desc = "change panel to down" }, opts)
map("n", "H", function() require("smart-splits").move_cursor_left() end, { desc = "change panel to left" }, opts)
map("n", "L", function() require("smart-splits").move_cursor_right() end, { desc = "change panel to right" }, opts)
map("n", "J", function() require("smart-splits").move_cursor_down() end, { desc = "change panel to up" }, opts)
map("n", "K", function() require("smart-splits").move_cursor_up() end, { desc = "change panel to down" }, opts)
-- map("n", "<C-h>", "<C-w>h", { desc = "change panel to left" }, opts)
-- map("n", "<C-l>", "<C-w>l", { desc = "change panel to right" }, opts)
-- map("n", "<C-j>", "<C-w>j", { desc = "change panel to up" }, opts)
-- map("n", "<C-k>", "<C-w>k", { desc = "change panel to down" }, opts)
-- map("n", "H", "<C-w>h", { desc = "change panel to left" }, opts)
-- map("n", "L", "<C-w>l", { desc = "change panel to right" }, opts)
-- map("n", "J", "<C-w>j", { desc = "change panel to up" }, opts)
-- map("n", "K", "<C-w>k", { desc = "change panel to down" }, opts)

-- Resize window
map("n", "<C-up>", function() require("smart-splits").resize_up() end, { desc = "resize window" }, opts)
map("n", "<C-down>", function() require("smart-splits").resize_down() end, { desc = "resize window" }, opts)
map("n", "<C-left>", function() require("smart-splits").resize_left() end, { desc = "resize window" }, opts)
map("n", "<C-right>", function() require("smart-splits").resize_right() end, { desc = "resize window" }, opts)

-- Packer
-- map("n", "<leader>ps", "<cmd>PackerSync<Cr>", { desc = "packer sync" }, opts)
-- map("n", "<leader>pS", "<cmd>PackerStatus<Cr>", { desc = "packer status" }, opts)
-- map("n", "<leader>pc", "<cmd>PackerCompile<Cr>", { desc = "packer compile" }, opts)
-- map("n", "<leader>pC", "<cmd>PackerClean<Cr>", { desc = "packer clean" }, opts)

-- For buffers
map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" }, opts)
map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous Buffer" }, opts)
map("n", "<leader>x", "<Cmd>bd<Cr>", { desc = "close buffer" }, opts)

-- For Nvim tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<Cr>", { desc = "Toggle Nvim tree" }, opts)
map("n", "<leader>o", "<cmd>NvimTreeFocus<Cr>", { desc = "Focus Nvim tree" }, opts)

-- Diagnostics
map("n", "[d", function () vim.diagnostic.goto_prev() end, { desc = "jump prev diagonstic" }, opts)
map("n", "]d", function () vim.diagnostic.goto_next() end, { desc = "jump next diagonstic" }, opts)

-- For telescope
map("n", "<leader>ft", function() require("telescope.builtin").colorscheme() end, { desc = "change colorscheme" }, opts)
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Search files" }, opts)
map("n", "<leader>fF", function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end, { desc = "Search all files" }, opts)
map("n", "<leader>fw", function() require("telescope.builtin").live_grep() end, { desc = "Search words" }, opts)
map("n", "<leader>fW", function() require("telescope.builtin").live_grep({ additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end, }) end, { desc = "Search words in all files" }, opts)
map("n", "<leader>gs", function() require("telescope.builtin").git_status() end, { desc = "Git status" }, opts)
map("n", "<leader>gb", function() require("telescope.builtin").git_branches() end, { desc = "Git branches" }, opts)
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "search buffers" }, opts)
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Search help" }, opts)
map("n", "<leader>fm", function() require("telescope.builtin").marks() end, { desc = "Search marks" }, opts)
map("n", "<leader>fo", function() require("telescope.builtin").oldfiles() end, { desc = "Search history" }, opts)
map("n", "<leader>fc", function() require("telescope.builtin").grep_string() end, { desc = "Search for word under cursor" }, opts)
map("n", "<leader>fM", function() require("telescope.builtin").man_pages() end, { desc = "Search man" }, opts)
map("n", "<leader>fr", function() require("telescope.builtin").registers() end, { desc = "Search registers" }, opts)
map("n", "<leader>fk", function() require("telescope.builtin").keymaps() end, { desc = "Search keymaps" }, opts)
map("n", "<leader>fC", function() require("telescope.builtin").commands() end, { desc = "Search commands" }, opts)
map("n", "<leader>fd", function() require("telescope.builtin").diagnostics() end, { desc = "Search diagnostics" }, opts)
