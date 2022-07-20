function CreateNoremapGlobal(type, opts)
	return function(lhs, rhs)
		vim.api.nvim_set_keymap(type, lhs, rhs, opts)
	end
end

function CreateNoremap(type, opts)
	return function(lhs, rhs, bufnr)
        bufnr = bufnr or 0
		vim.api.nvim_buf_set_keymap(bufnr, type, lhs, rhs, opts)
	end
end
Nnoremap = CreateNoremap("n", { noremap = true })
Inoremap = CreateNoremap("i", { noremap = true })

NnoremapGlobal = CreateNoremapGlobal("n", { noremap = true })
require("configs.my_settings")
require("configs.my_plugins")
require("configs.my_which_key")
require("configs.flutter_tools_config")
require("configs.telescope")
require("configs.context")
