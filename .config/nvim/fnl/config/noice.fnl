(import-macros {: setup : map! : reqcall} :macros)

(when (not vim.g.started_by_firenvim)
  (local opts {:border :single
               :max_width 80})
  (setup :noice {:lsp {:override {:vim.lsp.util.convert_input_to_markdown_lines true
                                  :vim.lsp.util.stylize_markdown true
                                  :cmp.entry.get_documentation true}
                       :hover {:opts opts}
                       :signature {:enabled false
                                   :opts opts}}})

  (map! [n :expr] :<c-f> #(if (not (reqcall :noice.lsp :scroll 4)) :<c-f>))
  (map! [n :expr] :<c-b> #(if (not (reqcall :noice.lsp :scroll -4)) :<c-b>)))
