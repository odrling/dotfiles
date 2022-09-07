(import-macros {: g! : color! : hl!} :macros)

;; polyglot disable modules
(g! polyglot_disabled [:autoindent :sensible])

;; vim.notify
(hl! Normal {:bg "#000000"})
(let [(ok? notify) (pcall require :notify)]
  (when ok?
    (notify.setup {:max_width 80})
    (set vim.notify notify)))
