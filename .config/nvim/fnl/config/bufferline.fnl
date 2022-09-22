(import-macros {: setup : map!} :macros)

(setup :bufferline {:options {:show_buffer_close_icons false
                              :show_close_icon false
                              :diagnostics :nvim_lsp}})

;; (map! [n] :<leader>q "<cmd>BufferClose<cr>")
;; (map! [n] :<leader>Q "<cmd>silent! BufferCloseAllButCurrentOrPinned<cr>")
(map! [n] :<leader>b "<cmd>BufferLinePick<cr>")
(map! [n] :<leader>P "<cmd>BufferLineTogglePin<cr>")
