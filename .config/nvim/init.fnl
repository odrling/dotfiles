(import-macros {: augroup!} :macros)

(require :settings)
(require :before)
(require :sync)

(vim.schedule #(require :config.packer))
