(import-macros {: setup : map!} :macros)

(setup :todo-comments {})

(map! [n] :<leader>T "<CMD>TodoTelescope<CR>")
