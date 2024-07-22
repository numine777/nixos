M = {}

function M.setup()
    require("persistence").setup({})
	-- load the session for the current directory
	vim.keymap.set("n", "<leader>qs", function()
		require("persistence").load()
	end)

	-- select a session to load
	vim.keymap.set("n", "<leader>qS", function()
		require("persistence").select()
	end)

	-- load the last session
	vim.keymap.set("n", "<leader>ql", function()
		require("persistence").load({ last = true })
	end)

	-- stop Persistence => session won't be saved on exit
	vim.keymap.set("n", "<leader>qd", function()
		require("persistence").stop()
	end)

	vim.api.nvim_create_autocmd({ "BufReadPre" }, {
		group = vim.api.nvim_create_augroup("PersistenceStart", {}),
		callback = function()
            require("persistence").start()
		end,
	})
end

return M
