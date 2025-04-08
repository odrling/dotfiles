(import-macros {: setup} :macros)
(local mason_utils (require :config.lsp.mason))

;; linter/formatter setup
(local null_ls (require :null-ls))
(local luacheck_diagnostics (require :none-ls-luacheck.diagnostics.luacheck))
(local sources [null_ls.builtins.diagnostics.teal
                null_ls.builtins.formatting.stylua
                luacheck_diagnostics
                null_ls.builtins.formatting.prettier])

(when (not vim.env.NVIM_NO_MYPY_DIAGNOSTICS)
      (table.insert sources null_ls.builtins.diagnostics.mypy))

(null_ls.setup {:sources sources
                :diagnostics_format "[#{s}] #{c}: #{m}"})
