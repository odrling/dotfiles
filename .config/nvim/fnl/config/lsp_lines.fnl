(import-macros {: setup} :macros)

(setup :lsp_lines {})
(vim.diagnostic.config {:virtual_text false
                        :virtual_lines {:only_current_line true}})


(local M {})

(fn M.toggle []
  (let [config (vim.diagnostic.config)]
       (vim.diagnostic.config {:virtual_lines {:only_current_line (not config.virtual_lines.only_current_line)}})))

:return M
