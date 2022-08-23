(import-macros {: map! : augroup! : exec : set!} :hibiscus.vim)
(import-macros {: setup : cfgcall} :macros)

(fn on_attach [client bufnr]
  (cfgcall :lsp_signature :on_attach {:always_trigger true})

  ; scroll down hover doc or scroll in definition preview
  (map! [n] :<C-f> '((. (require :lspsaga.action) :smart_scroll_with_saga) 1))
  (map! [n] :<C-b> '((. (require :lspsaga.action) :smart_scroll_with_saga) -1))
  ; show diagnostic
  (map! [n] :<leader>cd "<cmd>Lspsaga show_line_diagnostics<CR>")
  (map! [n] :<leader>cc "<cmd>Lspsaga show_cursor_diagnostics<CR>")
  ; show line diagnostics automatically in hover window
  (augroup! :lspsaga
            [[CursorHold CursorHoldI] :* "Lspsaga show_line_diagnostics"])

  (map! [n :buffer] :gD 'vim.lsp.buf.declaration)
  (map! [n :buffer] :gd 'vim.lsp.buf.definition)
  (map! [n :buffer] :K "<cmd>Lspsaga hover_doc<CR>")
  (map! [n :buffer] :gi 'vim.lsp.buf.implementation)
  (map! [n :buffer] :<C-k> 'vim.lsp.buf.signature_help)
  (map! [n :buffer] :<leader>r "<cmd>Lspsaga rename<CR>")
  (map! [n :buffer] :<leader>ca 'vim.lsp.buf.code_action)
  (map! [n :buffer] :gr 'vim.lsp.buf.references)
  (map! [n :buffer] :<leader>r '(vim.lsp.buf.format {:async true}))

  (when client.server_capabilities.documentHighlightProvider
    (exec [[:hi! "LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow"]
           [:hi! "LspReferenceText cterm=bold ctermbg=red guibg=LightYellow"]
           [:hi! "LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow"]])
    ;close enough
    (augroup! :lsp_document_highlight
              [[CursorHold CursorHoldI] * 'vim.lsp.buf.document_highlight]
              [[CursorMoved] * 'vim.lsp.buf.clear_references])))

; add additional capabilities supported by nvim-cmp
(var capabilities (vim.lsp.protocol.make_client_capabilities))
(let [cmp_nvim_lsp (require :cmp_nvim_lsp)]
  (set capabilities (cmp_nvim_lsp.update_capabilities capabilities)))

; Neovim does not currently include built-in snippets.
; vscode-json-language-server only provides completions when snippet support
; is enabled)
(set capabilities.textDocument.completion.completionItem.snippetSupport true)
(set! completeopt "menuone,noselect")

; luasnip
(local luasnip (require :luasnip))
(cfgcall :luasnip.loaders.from_vscode :lazy_load)

; nvim-cmp setup
(local cmp (require :cmp))
(let [cmp_autopairs (require :nvim-autopairs.completion.cmp)]
  (cmp.event:on :confirm_done (cmp_autopairs.on_confirm_done {:map_char {:tex ""}})))

(cmp.setup {:snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
            :mapping {:<C-p> (cmp.mapping.select_prev_item)
                      :<C-n> (cmp.mapping.select_prev_item)
                      :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                  :select true})
                      :<Tab> (fn [fallback]
                               (if (cmp.visible
                                     (cmp.select_next_item))
                                   (luasnip.expand_or_jumpable)
                                   (luasnip.expand_or_jump)
                                   (fallback)))
                      :<S-Tab> (fn [fallback]
                                 (if (cmp.visible
                                      (cmp.select_prev_item))
                                    (luasnip.jumpable -1
                                      (luasnip.jump -1))
                                    (fallback)))}
            :sources [{:name :nvim_lsp}
                      {:name :conjure}
                      {:name :luasnip}
                      {:name :path}
                      {:name :treesitter}
                      {:name :latex_symbols}
                      {:name :emoji}]})

(cmp.setup.filetype :gitcommit {:sources (cmp.config.sources [{:name :cmp_git}
                                                              {:name :buffer}])})

(each [_ v (ipairs ["/" "?"])]
  (cmp.setup.cmdline v {:mapping (cmp.mapping.preset.cmdline)
                        :sources [{:name :buffer}]}))

(cmp.setup.cmdline ":" {:mapping (cmp.mapping.preset.cmdline)
                        :sources [{:name :path}
                                  {:name :cmdline}]})

(setup :cmp_git)

(cfgcall :lspsaga :init_lsp_saga)

(setup :mason)
(setup :mason-lspconfig {:automatic_installation true})

(let [signs {:Error :E
             :Warn :W
             :Hint :H
             :Info :I}]
  (each [type icon (pairs signs)]
    (let [hl (.. :DiagnosticSign type)]
      (vim.fn.sign_define hl {:text icon
                              :texthl hl
                              :numhl hl}))))

(lambda setup_ls [lsp options]
  (local settings (vim.tbl_deep_extend :force {:on_attach on_attach
                                               :capabilities capabilities} options))
  ((. (. (require :lspconfig) lsp) :setup) settings))

(let [servers [:pyright :jdtls :clangd :lemminx :tsserver :vimls]]
  (each [_ lsp (ipairs servers)] (setup_ls lsp {})))

(local schemastore (require :schemastore))
(setup_ls :jsonls {:settings {:json {:validate {:enable true}
                                       :schemas (schemastore.json.schemas)}}})

(setup_ls :yamlls {:settings {:yaml {:schemaStore {:enable true}}}})

(setup_ls :taplo {:settings {:toml {:schemas (schemastore.json.schemas)}}})

(local null_ls (require :null-ls))
(let [sources [null_ls.builtins.diagnostics.flake8
               (null_ls.builtins.formatting.isort.with {:args ["--stdout" "--profile" "black" "-e"]})]]
  (null_ls.setup {:sources sources
                  :diagnostics_format "[#{s}] #{c}: #{m}"}))
