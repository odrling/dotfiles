(import-macros {: setup} :macros)

;; colorscheme
(setup :github-theme {:theme_style :light
                      :overrides (fn [c]
                                   {:CursorLine {:bg "#f8f8f8"}
                                    :ColorColumn {:bg "#f8f8f8"}})})

;; telescope bindings
(require :config.telescope.bindings)

;; auto-session
(require :config.auto-session)
