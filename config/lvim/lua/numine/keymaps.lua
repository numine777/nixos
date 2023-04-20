local Remap = require("numine.mapper")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

lvim.keys.normal_mode["H"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["L"] = "<cmd>BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<C-e>"] = ":lua require('harpoon.ui').toggle_quick_menu()<CR>"
lvim.keys.normal_mode["<C-h>"] = ":lua require('harpoon.ui').nav_file(1)<CR>"
lvim.keys.normal_mode["<C-t>"] = ":lua require('harpoon.ui').nav_file(2)<CR>"
lvim.keys.normal_mode["<C-n>"] = ":lua require('harpoon.ui').nav_file(3)<CR>"
lvim.keys.normal_mode["<C-s>"] = ":lua require('harpoon.ui').nav_file(4)<CR>"
lvim.keys.normal_mode["<C-j>"] = ":cprev<CR>"
lvim.keys.normal_mode["<C-k>"] = ":cnext<CR>"
lvim.keys.normal_mode["<C-f>"] =
	':lua require("harpoon.term").sendCommand(1, "tmux-sessionizer\\n"); require("harpoon.term").gotoTerminal(1)<CR>'
lvim.keys.normal_mode["<C-p>"] = require("lvim.core.telescope.custom-finders").find_project_files
inoremap("<C-c>", "<Esc>")
lvim.keys.term_mode["<Esc>"] = "<C-\\><C-n>"
lvim.keys.term_mode["<C-j>"] = "<C-\\><C-n><C-w>q"
lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs + 1] = { "lldb", "tg", "Clang Debugger" }
-- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs + 1] = { "lazydocker", "<leader>zd", "LazyDocker" }

lvim.builtin.which_key.mappings["E"] = { "<cmd>lua require('lir.float').init()<cr>", "Open float explorer" }
-- lvim.builtin.which_key.mappings["e"] = { ":Ex<CR>", "Explorer" }
-- lvim.builtin.which_key.mappings["e"] = { ":lua require'lir.float'.init()<CR>", "Lir" }
lvim.builtin.which_key.mappings["f"] = { "<cmd>lua require('lvim.lsp.utils').format()<cr>", "Format" }
lvim.builtin.which_key.mappings["u"] = { ":UndotreeToggle<CR>", "Undo Tree" }
lvim.builtin.which_key.mappings["x"] = { '"_dd', "Delete" }
lvim.builtin.which_key.vmappings["x"] = { '"_d', "Delete" }
lvim.builtin.which_key.mappings["y"] = { '"+y', "Yank to clipboard" }
lvim.builtin.which_key.vmappings["y"] = { '"+y', "Yank to clipboard" }
-- lvim.builtin.which_key.mappings["J"] = { ":cprev<CR>", "Globalist Prev" }
-- lvim.builtin.which_key.mappings["K"] = { ":cnext<CR>", "Globalist Next" }
lvim.builtin.which_key.mappings["a"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Harpoon Add File" }
lvim.builtin.which_key.mappings["S"] = { ":Scratch<CR>", "Scratch" }
lvim.builtin.which_key.mappings["b"]["p"] = { ":lua print(vim.fn.bufname())<cr>", "Print file path" }
-- lvim.builtin.which_key.mappings["g"]["g"] = { ":G<cr>", "Fugitive" }
lvim.builtin.which_key.mappings["g"]["w"] = {
	"<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
	"View Git Worktrees",
}
lvim.builtin.which_key.mappings["g"]["m"] = {
	"<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
	"New Git Worktree",
}
lvim.builtin.which_key.mappings["g"]["n"] = {
	":G<cr>",
	"Open Fugitive",
}
-- lvim.builtin.which_key.mappings["t"] = {
-- 	name = "+Harpoon",
-- 	t = { "<C-w>s<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>", "Go to Terminal 1" },
-- 	e = { "<C-w>s<cmd>lua require('harpoon.term').gotoTerminal(2)<cr>", "Go to Terminal 2" },
-- 	-- o = {"<cmd>lua require('harpoon.term').sendCommand(1, 1)<cr>", "Send Command 1"},
-- 	-- i = {"<cmd>lua require('harpoon.term').sendCommand(1, 2)<cr>", "Send Command 2"},
-- }
lvim.builtin.which_key.mappings["s"]["y"] = {
	'<cmd>lua require("telescope.builtin").live_grep({ type_filter = vim.fn.input("File Type > ") })<CR>',
	"Search by file type",
}

-- lvim.builtin.which_key.mappings["F"] = {
-- 	name = "+Flutter",
-- 	c = { "<cmd>lua require('telescope').extensions.flutter.commands()<cr>", "View Flutter Commands" },
-- }
