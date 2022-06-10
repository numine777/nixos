lvim.keys.normal_mode["<C-e>"] = ":lua require('harpoon.ui').toggle_quick_menu()<CR>"
lvim.keys.normal_mode["<C-h>"] = ":lua require('harpoon.ui').nav_file(1)<CR>"
lvim.keys.normal_mode["<C-t>"] = ":lua require('harpoon.ui').nav_file(2)<CR>"
lvim.keys.normal_mode["<C-n>"] = ":lua require('harpoon.ui').nav_file(3)<CR>"
lvim.keys.normal_mode["<C-s>"] = ":lua require('harpoon.ui').nav_file(4)<CR>"
lvim.keys.normal_mode["<C-j>"] = ":lprev<CR>"
lvim.keys.normal_mode["<C-k>"] = ":lnext<CR>"
lvim.keys.normal_mode["<C-f>"] =
	':lua require("harpoon.term").sendCommand(1, "tmux-sessionizer\\n"); require("harpoon.term").gotoTerminal(1)<CR>'
lvim.keys.term_mode["<Esc>"] = "<C-\\><C-n>"
lvim.builtin.which_key.mappings["e"] = { ":Ex<CR>", "Explorer" }
lvim.builtin.which_key.mappings["y"] = { '"+y', "Yank to clipboard" }
lvim.builtin.which_key.vmappings["y"] = { '"+y', "Yank to clipboard" }
lvim.builtin.which_key.mappings["d"] = { '"_d', "Delete" }
lvim.builtin.which_key.vmappings["d"] = { '"_d', "Delete" }
lvim.builtin.which_key.mappings["p"] = { '"+p', "Put from clipboard" }
lvim.builtin.which_key.vmappings["p"] = { '"+p', "Put from clipboard" }
lvim.builtin.which_key.mappings["J"] = { ":cprev<CR>", "Globalist Prev" }
lvim.builtin.which_key.mappings["K"] = { ":cnext<CR>", "Globalist Next" }
lvim.builtin.which_key.mappings["a"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Harpoon Add File" }
lvim.builtin.which_key.mappings["S"] = { ":Scratch<CR>", "Scratch" }
lvim.builtin.which_key.mappings["b"]["n"] = { ":lua print(vim.fn.bufname())<cr>", "Print bufname" }
-- lvim.builtin.which_key.mappings["g"]["g"] = { ":G<cr>", "Fugitive" }
lvim.builtin.which_key.mappings["g"]["w"] = {
	"<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
	"View Git Worktrees",
}
lvim.builtin.which_key.mappings["g"]["m"] = {
	"<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
	"New Git Worktree",
}
lvim.builtin.which_key.mappings["t"] = {
	name = "+Harpoon",
	u = { "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>", "Go to Terminal 1" },
	e = { "<cmd>lua require('harpoon.term').gotoTerminal(2)<cr>", "Go to Terminal 2" },
	-- o = {"<cmd>lua require('harpoon.term').sendCommand(1, 1)<cr>", "Send Command 1"},
	-- i = {"<cmd>lua require('harpoon.term').sendCommand(1, 2)<cr>", "Send Command 2"},
}

-- lvim.builtin.which_key.mappings["F"] = {
-- 	name = "+Flutter",
-- 	c = { "<cmd>lua require('telescope').extensions.flutter.commands()<cr>", "View Flutter Commands" },
-- }
lvim.builtin.which_key.mappings["P"] = {
	name = "Packer",
	c = { "<cmd>PackerCompile<cr>", "Compile" },
	i = { "<cmd>PackerInstall<cr>", "Install" },
	r = { "<cmd>lua require('utils').reload_lv_config()<cr>", "Reload" },
	s = { "<cmd>PackerSync<cr>", "Sync" },
	S = { "<cmd>PackerStatus<cr>", "Status" },
	u = { "<cmd>PackerUpdate<cr>", "Update" },
}
