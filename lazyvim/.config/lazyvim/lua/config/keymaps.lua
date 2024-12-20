-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by lazyvim.config.init
vim.keymap.del("n", "<leader>qq")
vim.keymap.del("n", "<leader>w")
vim.keymap.del("n", "<leader>wd")

vim.keymap.set("n", "<leader>q", "<Cmd>confirm q<CR>", { desc = "Quit Window", silent = true, noremap = true })
vim.keymap.set("n", "<leader>Q", "<Cmd>confirm qall<CR>", { desc = "Quit All Windows", silent = true, noremap = true })
vim.keymap.set("n", "<C-Q>", "<Cmd>q!<CR>", { desc = "Force quit", noremap = true })
vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>", { desc = "Save file", silent = true, noremap = true })
vim.keymap.set(
  { "n", "i", "x" },
  "<C-S>",
  "<Cmd>silent! update! | redraw<CR>",
  { desc = "Force write", noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>uo", "<Cmd>lua require('nvchad.themes').open()<CR>", { desc = "Save file", silent = true, noremap = true })
