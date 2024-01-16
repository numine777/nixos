(import-macros {: map!} :macros)

(local harpoon (autoload :harpoon))
(harpoon.setup { :settings { :save_on_toggle true}})

(fn toggle_quick_menu []
    (let [list (harpoon:list)] (harpoon.ui:toggle_quick_menu list)))

(fn select [index]
    (let [list (harpoon:list)] (list:select index)))

(map! [n] :<leader>a (lambda [] (let [list (harpoon:list)] (list:append))) {:desc "Add file to harpoon list"})
(map! [n] :<C-e> toggle_quick_menu {:desc "Show harpoon window"})

(map! [n] :<C-h> (lambda [] (select 1)) {:desc "Show harpoon window"})
(map! [n] :<C-t> (lambda [] (select 2)) {:desc "Show harpoon window"})
(map! [n] :<C-n> (lambda [] (select 3)) {:desc "Show harpoon window"})
(map! [n] :<C-s> (lambda [] (select 4)) {:desc "Show harpoon window"})
