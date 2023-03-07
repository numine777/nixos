local init = function()
	local window_width_limit = 100

	local conditions = {
		buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
		end,
		hide_in_width = function()
			return vim.o.columns > window_width_limit
		end,
		-- check_git_workspace = function()
		--   local filepath = vim.fn.expand "%:p:h"
		--   local gitdir = vim.fn.finddir(".git", filepath .. ";")
		--   return gitdir and #gitdir > 0 and #gitdir < #filepath
		-- end,
	}

	local lsp = {
		function(msg)
			msg = msg or "LS Inactive"
			local buf_clients = vim.lsp.get_active_clients()
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

			-- add formatter
			-- local formatters = require("lvim.lsp.null-ls.formatters")
			-- local supported_formatters = formatters.list_registered(buf_ft)
			-- vim.list_extend(buf_client_names, supported_formatters)

			-- add linter
			-- local linters = require("lvim.lsp.null-ls.linters")
			-- local supported_linters = linters.list_registered(buf_ft)
			-- vim.list_extend(buf_client_names, supported_linters)

			local unique_client_names = vim.fn.uniq(buf_client_names)

			local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

			if copilot_active then
				language_servers = language_servers .. "%#SLCopilot#" .. " " .. "" .. "%*"
			end

			return language_servers
		end,
		color = { gui = "bold" },
		cond = conditions.hide_in_width,
	}

	local function get_theme()
		if vim.g.numine_colorscheme ~= "gruvbuddy" then
			return vim.g.numine_colorscheme
		else
			return "auto"
		end
	end

	local theme = get_theme()

	require("lualine").setup({
		options = {
			-- icons_enabled = false,
			-- theme = function()
			--     if vim.g.numine_colorscheme ~= "gruvbuddy" then
			--         return vim.g.numine_colorscheme
			--     else
			--         return "auto"
			--     end
			-- end,
			theme = theme,
			component_separators = "|",
			section_separators = "",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = { "filename", "diagnostics" },
			lualine_x = { lsp, "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
	})
end

if not vim.g.vscode then
	init()
end
