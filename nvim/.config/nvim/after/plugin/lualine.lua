local status, lualine = pcall(require, "lualine")
if not status then
  return
end

-- git changes in opened file
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

-- get current active lsp clients with this functions
local function lsp_client()
  local buf_clients = vim.lsp.get_active_clients()
  if next(buf_clients) == nil then
    return ""
  end
  local buf_client_names = {}
  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end
  return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

local function lsp_progress(_, is_active)
  if not is_active then
    return
  end
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ""
  end
  local status = {}
  for _, msg in pairs(messages) do
    local title = ""
    if msg.title then
      title = msg.title
    end
    table.insert(status, (msg.percentage or 0) .. "%% " .. title)
  end
  -- local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  -- local ms = vim.loop.hrtime() / 1000000
  -- local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, "  ")
end

local config = {
  options = {
    icons_enabled = true,
    theme = "auto",
    section_separators = "",
    component_separators = "",
    disabled_filetypes = {},
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
      {
        "diff",
        source = diff_source,
        symbols = {
          added = " ",
          modified = " ",
          removed = " ",
        },
        padding = { left = 2, right = 1 },
        diff_color = {
          added = { fg = "#00FF00" },
          modified = { fg = "#FFBF00" },
          removed = { fg = "#FF3131" },
        },
      },
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
      { lsp_client, icon = " " },
      { lsp_progress },
    },
    lualine_y = {
      "filetype",
    },
    lualine_z = { "progress", "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "fugitive" },
}

lualine.setup(config)
