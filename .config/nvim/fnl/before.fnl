(import-macros {: g! : color! : hl!} :macros)

;; colorscheme
(color! github_light)
(hl! CursorLine {:bg "#f8f8f8"})

;; vim.notify
(require :config.notifier)

;; telescope bindings
(require :config.telescope.bindings)
