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

local config = {
	options = {
		icons_enabled = true,
		theme = "rose-pine",
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
			{
				function(msg)
					msg = msg or "LS Inactive"
					local buf_clients = vim.lsp.buf_get_clients()
					if next(buf_clients) == nil then
						-- TODO: clean up this if statement
						if type(msg) == "boolean" or #msg == 0 then
							return "LS Inactive"
						end
						return msg
					end
					local buf_ft = vim.bo.filetype
					local buf_client_names = {}
					local copilot_active = false

					-- add client
					for _, client in pairs(buf_clients) do
						if client.name ~= "null-ls" and client.name ~= "copilot" then
							table.insert(buf_client_names, client.name)
						end

						if client.name == "copilot" then
							copilot_active = true
						end
					end

					local unique_client_names = vim.fn.uniq(buf_client_names)

					local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

					if copilot_active then
						language_servers = language_servers .. "%#SLCopilot#" .. " " .. " " .. "%*"
					end

					return language_servers
				end,
			},
			{
				"filetype",
			},
		},
		lualine_y = { "location" },
		lualine_z = {
			{
				"progress",
				fmt = function()
					return "%P/%L"
				end,
				color = {},
			},
		},
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
