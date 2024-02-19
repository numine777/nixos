local harpoon = require("harpoon")
harpoon:setup({
    settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
    },
})

lvim.builtin.which_key.mappings["a"] = { function() harpoon:list():append() end, "Harpoon Add File" }

lvim.keys.normal_mode["<C-e>"] = "lua require('harpoon').ui:toggle_quick_menu(harpoon:list())<CR>"
lvim.keys.normal_mode["<C-h>"] = function() harpoon:list():select(1) end
lvim.keys.normal_mode["<C-t>"] = function() harpoon:list():select(2) end
lvim.keys.normal_mode["<C-n>"] = function() harpoon:list():select(3) end
lvim.keys.normal_mode["<C-s>"] = function() harpoon:list():select(4) end
