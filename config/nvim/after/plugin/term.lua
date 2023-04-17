if not vim.g.vscode then
	vim.keymap.set("n", "<leader>h", function()
		require("nvterm.terminal").new("horizontal")
	end)
	vim.keymap.set("n", "<leader>v", function()
		require("nvterm.terminal").new("vertical")
	end)
	vim.keymap.set("n", "<leader>pt", "<cmd>Telescope terms<CR>")
end
