(import-macros {: augroup! : autocmd! : local-set! : map!} :macros)

;; (augroup! Numine_Fugitive (autocmd! FileType fugitive
;;                                  `(local-set! nolist))

(map! [n] :<leader>gn :G<CR> {:desc "Open fugitive"})
