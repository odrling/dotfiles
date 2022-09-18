(import-macros {: g! : color! : hl!} :macros)

;; colorscheme
(color! github_light)
(hl! CursorLine {:bg "#fafafa"})

;; vim.notify
(require :config.notify)

;; set packer compile path
(tset _G :packer_compile_path (.. (vim.fn.stdpath :cache) "/packer_compiled.lua"))
