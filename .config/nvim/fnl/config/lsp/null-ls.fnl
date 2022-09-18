(import-macros {: setup} :macros)
(local mason_utils (require :config.lsp.mason))

(mason_utils.ensure_tools :flake8 :isort :stylua :mypy)

;; linter/formatter setup
(local null_ls (require :null-ls))
(local sources [null_ls.builtins.diagnostics.flake8
                null_ls.builtins.formatting.isort
                null_ls.builtins.diagnostics.teal
                null_ls.builtins.formatting.stylua])

(when vim.env.NVIM_MYPY_DIAGNOSTICS
                (table.insert sources null_ls.builtins.diagnostics.mypy))

(null_ls.setup {:sources sources
                :diagnostics_format "[#{s}] #{c}: #{m}"})
