(import-macros {: setup : map!} :macros)

(setup :neogit {:disable_signs false
                :disable_context_highlighting false
                :disable_commit_confirmation false

                ;         [CLOSED, OPENED]
                :signs {:section [">" "v"]
                        :item [">" "v"]
                        :hunk ["" ""]}

                :mappings {:status {:<leader>q "Close"}}
                :integrations {:diffview true}})

(map! [n] :<leader>n :<cmd>Neogit<CR>)
