return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    opts = {
      workspaces = {
        {
          name = "work",
          path = "~/notes",
        },
      },
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like 'my-new-note-1657296016', and therefore the file name 'my-new-note-1657296016.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return suffix .. "-" .. tostring(os.time())
      end,
    },
    keys = {
      { "<leader>bs", ":ObsidianQuickSwitch<CR>", desc = "Obsidian Quick Switch" },
      { "<leader>bn", ":ObsidianNew<CR>", desc = "Obsidian New" },
    },
  },
}
