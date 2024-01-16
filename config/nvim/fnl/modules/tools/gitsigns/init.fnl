(import-macros {: use-package!} :macros)

; This makes handling git not suck
(use-package! :lewis6991/gitsigns.nvim {:nyoom-module tools.gitsigns})
