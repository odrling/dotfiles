(import-macros {: set! : setup : augroup!} :macros)

(require :config.lsp.servers)
(require :config.lsp.null-ls)

(augroup! :diagnostics
                    [[CursorHold] * #(vim.diagnostic.open_float {:scope :cursor
                                                                 :source true
                                                                 :focus false})])

(vim.diagnostic.config {:float {:border :single
                                :max_width 80}})
