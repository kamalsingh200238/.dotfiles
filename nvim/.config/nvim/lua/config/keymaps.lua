-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by lazyvim.config.init
vim.keymap.del("n", "<leader>qq")
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

vim.keymap.set({ "n", "v" }, "<leader>cy", function()
  local file = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
  local line_start = math.min(vim.fn.line("v"), vim.fn.line("."))
  local line_end = math.max(vim.fn.line("v"), vim.fn.line("."))
  local lines = line_start == line_end and string.format("Line:%d", line_start)
    or string.format("Line:%d-%d", line_start, line_end)
  local result = string.format("File:./%s %s", file, lines)
  vim.fn.setreg("+", result)
  print("Copied: " .. result)
end, { desc = "Copy relative path and line range" })

vim.keymap.set({ "n", "v" }, "<leader>cY", function()
  local file = vim.fn.expand("%:p")
  local line_start = math.min(vim.fn.line("v"), vim.fn.line("."))
  local line_end = math.max(vim.fn.line("v"), vim.fn.line("."))
  local lines = line_start == line_end and string.format("Line:%d", line_start)
    or string.format("Line:%d-%d", line_start, line_end)
  local result = string.format("File:%s %s", file, lines)
  vim.fn.setreg("+", result)
  print("Copied: " .. result)
end, { desc = "Copy absolute path and line range" })
