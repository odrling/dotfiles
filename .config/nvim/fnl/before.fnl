(import-macros {: g! : color! : hl!} :macros)

;; polyglot disable modules
(g! polyglot_disabled [:autoindent :sensible])

;; vim.notify
(require :config.notify)
