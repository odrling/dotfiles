(import-macros {: setup : map! : reqcall} :macros)

(local opts {:border :single
             :size {:width 80}
             :position {:row 2
                        :col 0}})
(setup :noice {:lsp {:override {:vim.lsp.util.convert_input_to_markdown_lines true
                                :vim.lsp.util.stylize_markdown true
                                :cmp.entry.get_documentation true}
                     :documentation {:opts opts}}
               :presets {:inc_rename true}}

  (map! [n :expr] :<c-f> #(if (not (reqcall :noice.lsp :scroll 4)) :<c-f>))
  (map! [n :expr] :<c-b> #(if (not (reqcall :noice.lsp :scroll -4)) :<c-b>)))
