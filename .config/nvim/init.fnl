(import-macros {: augroup!} :hibiscus.vim)

;autocmds
(augroup! :init
          [[BufWritePost] :init.fnl "silent! FnlCompileBuffer"])

(require :config.packer)
(require :settings)
