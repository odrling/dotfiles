(import-macros {: setup : map!} :macros)

(setup :bufferline {:closable false
                    :auto_hide true})

(map! [n] :<leader>q "<cmd>BufferClose<cr>")
(map! [n] :<leader>b "<cmd>BufferPick<cr>")
(map! [n] :<leader>p "<cmd>BufferPin<cr>")
