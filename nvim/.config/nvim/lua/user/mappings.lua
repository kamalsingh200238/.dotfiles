-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local M = {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    -- ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    -- ["<leader>bD"] = {
    --   function()
    --     require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
    --   end,
    --   desc = "Pick to close",
    -- },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    -- ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  v = {},
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}

local hop = require "hop"
M.n["s"] = { function() hop.hint_char1 { current_line_only = false } end, desc = "Hop on the word" }
M.n["S"] =
  { function() hop.hint_char1 { current_line_only = false, hint_offset = -1 } end, desc = "Hop before the word" }
M.v["s"] = M.n["s"]
M.v["S"] = M.n["S"]

return M
