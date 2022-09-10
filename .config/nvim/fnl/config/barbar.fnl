(import-macros {: setup : map!} :macros)

(local auto_hide (~= vim.g.started_by_firenvim nil))
(setup :bufferline {:closable false
                    :auto_hide auto_hide})

(map! [n] :<leader>q "<cmd>BufferClose<cr>")
(map! [n] :<leader>Q "<cmd>silent! BufferCloseAllButCurrentOrPinned<cr>")
(map! [n] :<leader>b "<cmd>BufferPick<cr>")
(map! [n] :<leader>P "<cmd>BufferPin<cr>")
