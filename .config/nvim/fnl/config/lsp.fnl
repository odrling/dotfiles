(import-macros {: set! : setup : augroup!} :macros)

(require :config.lsp.servers)
(require :config.lsp.null-ls)

(vim.diagnostic.config {:float {:border :single
                                :max_width 80}})
