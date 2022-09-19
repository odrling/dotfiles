(import-macros {: g! : color! : hl!} :macros)

;; colorscheme
(color! github_light)
(hl! CursorLine {:bg "#fafafa"})

;; vim.notify
(require :config.notify)

;; auto-session
(pcall require :config.auto-session)
