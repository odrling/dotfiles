(import-macros {: setup} :macros)
(local mason_utils (require :config.lsp.mason))

;; linter/formatter setup
(local null_ls (require :null-ls))
(local sources [null_ls.builtins.diagnostics.teal
                null_ls.builtins.formatting.stylua])

(when vim.env.NVIM_MYPY_DIAGNOSTICS
                (table.insert sources null_ls.builtins.diagnostics.mypy))

(null_ls.setup {:sources sources
                :diagnostics_format "[#{s}] #{c}: #{m}"})
