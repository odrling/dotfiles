(import-macros {: reqcall : setup} :macros)

; luasnip
(local luasnip (require :luasnip))
(reqcall :luasnip.loaders.from_vscode :lazy_load)

; nvim-cmp setup
(local cmp (require :cmp))
(let [cmp_autopairs (require :nvim-autopairs.completion.cmp)]
  (cmp.event:on :confirm_done (cmp_autopairs.on_confirm_done {:map_char {:tex ""}})))

(cmp.setup {:mapping {:<C-p>   (cmp.mapping.select_prev_item)
                      :<C-n>   (cmp.mapping.select_next_item)
                      :<TAB>   (fn [fallback]
                                 (if (cmp.visible)
                                     (cmp.select_next_item)
                                     (luasnip.expand_or_jumpable)
                                     (luasnip.expand_or_jump)
                                     (fallback)))
                      :<S-TAB> (fn [fallback]
                                 (if (cmp.visible)
                                   (cmp.select_prev_item)
                                   (luasnip.jumpable -1)
                                   (luasnip.jump -1)
                                   (fallback)))
                      :<CR>    (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace})}
            :snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
            :sources [{:name :luasnip}
                      {:name :nvim_lsp_signature_help}
                      {:name :nvim_lsp}
                      {:name :path}
                      {:name :buffer}
                      {:name :latex_symbols}]})

(cmp.setup.filetype :gitcommit {:sources (cmp.config.sources [{:name :cmp_git}
                                                              {:name :buffer}])})

(when (= vim.g.started_by_firenvim nil)
  (each [_ v (ipairs ["/" "?"])]
    (cmp.setup.cmdline v {:mapping (cmp.mapping.preset.cmdline)
                          :sources [{:name :buffer}]}))

  (cmp.setup.cmdline ":" {:mapping (cmp.mapping.preset.cmdline)
                          :sources [{:name :path}
                                    {:name :cmdline}]}))

(setup :cmp_git)
