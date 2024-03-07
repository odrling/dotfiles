(import-macros {: reqcall : setup} :macros)

; luasnip
(reqcall :luasnip.loaders.from_vscode :lazy_load)

; nvim-cmp setup
(local cmp (require :cmp))

(cmp.setup {:mapping {:<C-p>   (cmp.mapping.select_prev_item)
                      :<C-n>   (cmp.mapping.select_next_item)
                      :<TAB>   (fn [fallback]
                                 (if (not (cmp.complete_common_string))
                                     (if (cmp.visible)
                                       (cmp.select_next_item)
                                       (reqcall :luasnip :expand_or_jumpable)
                                       (reqcall :luasnip :expand_or_jump)
                                       (fallback))))
                      :<S-TAB> (fn [fallback]
                                 (if (cmp.visible)
                                   (cmp.select_prev_item)
                                   (reqcall :luasnip :jumpable -1)
                                   (reqcall :luasnip :jump -1)
                                   (fallback)))
                      :<CR>    (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace})}
            :snippet {:expand (fn [args] (reqcall :luasnip :lsp_expand args.body))}
            :sources [{:name :luasnip}
                      {:name :nvim_lsp}
                      {:name :path}
                      {:name :buffer}
                      {:name :latex_symbols}]
            :window {:documentation {:border :rounded}
                     :completion {:border :none
                                  :side_padding 1}}})

(cmp.setup.filetype :gitcommit {:sources (cmp.config.sources [{:name :git}
                                                              {:name :buffer}])})

(when (= vim.g.started_by_firenvim nil)
  (each [_ v (ipairs ["/" "?"])]
    (cmp.setup.cmdline v {:mapping (cmp.mapping.preset.cmdline)
                          :sources [{:name :buffer}]}))

  (cmp.setup.cmdline ":" {:mapping (cmp.mapping.preset.cmdline)
                          :sources [{:name :path}
                                    {:name :cmdline}]}))

