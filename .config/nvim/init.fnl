(import-macros {: augroup!} :macros)

;autocmds
(augroup! :init
          [[BufWritePost] :init.fnl "silent! FnlCompileBuffer"])

(require :config.packer)
(require :settings)
(require :sync)
