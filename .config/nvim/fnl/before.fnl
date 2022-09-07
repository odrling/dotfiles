(import-macros {: g! : color! : hl!} :macros)

;; polyglot disable modules
(g! polyglot_disabled [:autoindent :sensible])

(color! github_light)

;; vim.notify
(require :config.notify)
