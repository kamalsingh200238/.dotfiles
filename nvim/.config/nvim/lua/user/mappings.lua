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

M.n["se"] = {
  function() require("hop").hint_char1 { current_line_only = false } end,
  desc = "Hop on the word",
}
M.n["sE"] = {
  function() require("hop").hint_char1 { current_line_only = false, hint_offset = -1 } end,
  desc = "Hop before the word",
}
M.n["s/"] = {
  function() require("hop").hint_patterns { current_line_only = false } end,
  desc = "Find a pattern",
}
M.v["se"] = M.n["se"]
M.v["sE"] = M.n["sE"]

M.n["<leader>ff"] = {
  function() require("telescope.builtin").find_files { hidden = true, no_ignore = false } end,
  desc = "Find files",
}

M.n["<leader>sr"] = {
  function() require("spectre").open() end,
  desc = "Replace in files (Spectre)",
}

return M
