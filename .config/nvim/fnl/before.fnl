(import-macros {: setup} :macros)

;; colorscheme
(setup :github-theme {:theme_style :light
                      :overrides (fn [c]
                                   {:CursorLine {:bg "#f8f8f8"}})})

;; vim.notify
(require :config.notifier)

;; telescope bindings
(require :config.telescope.bindings)
