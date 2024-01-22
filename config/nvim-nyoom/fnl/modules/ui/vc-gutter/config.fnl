(import-macros {: map!} :macros)
(setup :gitsigns
       {:signs {:add {:hl :diffAdded
                      :text "│"
                      :numhl :GitSignsAddNr
                      :linehl :GitSignsAddLn}
                :change {:hl :diffChanged
                         :text "│"
                         :numhl :GitSignsChangeNr
                         :linehl :GitSignsChangeLn}
                :delete {:hl :diffRemoved
                         :text ""
                         :numhl :GitSignsDeleteNr
                         :linehl :GitSignsDeleteLn}
                :changedelete {:hl :diffChanged
                               :text "‾"
                               :numhl :GitSignsChangeNr
                               :linehl :GitSignsChangeLn}
                :topdelete {:hl :diffRemoved
                            :text "~"
                            :numhl :GitSignsDeleteNr
                            :linehl :GitSignsDeleteLn}}})


(local gitsigns (autoload :gitsigns))

(map! [n] :<leader>gj gitsigns.next_hunk {:desc "Go to next hunk"})
(map! [n] :<leader>gk gitsigns.prev_hunk {:desc "Go to prev hunk"})
(map! [n] :<leader>gl gitsigns.blame_line {:desc "Show line blame"})
(map! [n] :<leader>gp gitsigns.preview_hunk {:desc "Preview hunk"})
(map! [n] :<leader>gr gitsigns.reset_hunk {:desc "Reset hunk"})
(map! [n] :<leader>gR gitsigns.reset_buffer {:desc "Reset buffer"})
(map! [n] :<leader>gs gitsigns.stage_hunk {:desc "Stage hunk"})
(map! [n] :<leader>gu gitsigns.undo_stage_hunk {:desc "Unstage hunk"})
