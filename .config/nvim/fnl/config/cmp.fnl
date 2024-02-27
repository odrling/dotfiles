(import-macros {: reqcall : setup} :macros)

; nvim-cmp setup
(local cmp (require :cmp))

(cmp.setup {:mapping {:<C-p>   (cmp.mapping.select_prev_item)
                      :<C-n>   (cmp.mapping.select_next_item)
                      :<CR>    (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace})}
            :sources [{:name :nvim_lsp}
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

