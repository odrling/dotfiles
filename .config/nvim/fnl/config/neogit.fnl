(import-macros {: setup} :macros)

(setup :neogit {:disable_signs false
                :disable_context_highlighting false
                :disable_commit_confirmation false

                ;         [CLOSED, OPENED]
                :signs {:section [">" "v"]
                        :item [">" "v"]
                        :hunk ["" ""]}

                :integrations {:diffview true}})
