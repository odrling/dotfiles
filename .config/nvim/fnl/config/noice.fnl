(import-macros {: setup} :macros)

(if (not vim.g.started_by_firenvim)
  (setup :noice {:lsp {:override {:vim.lsp.util.convert_input_to_markdown_lines true
                                  :vim.lsp.util.stylize_markdown true
                                  :cmp.entry.get_documentation true}}}))
