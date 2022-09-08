(import-macros {: augroup! : exec : set! : setup : reqcall : map!} :macros)

(setup :inc_rename {})

(fn on_attach [client bufnr]
  (reqcall :lsp_signature :on_attach {:always_trigger true})

  (tset vim.lsp.handlers :textDocument/publishDiagnostics
    (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics {:virtual_text false}))

  (map! [n (:buffer bufnr)] :<leader>l #(: (require :config.hydras.lsp) :activate))
  (map! [n (:buffer bufnr)] :<leader>L #(reqcall :lsp_lines :toggle))

  (map! [n (:buffer bufnr)] :<leader>D "<cmd>Telescope diagnostics<CR>")
  (map! [n (:buffer bufnr)] :gD 'vim.lsp.buf.declaration)
  (map! [n (:buffer bufnr)] :K #(reqcall :lspsaga.hover :render_hover_doc))
  (map! [n (:buffer bufnr)] :gi 'vim.lsp.buf.implementation)
  (map! [n (:buffer bufnr)] :<C-k> 'vim.lsp.buf.signature_help)
  (map! [n (:buffer bufnr)] :<leader>r #(reqcall :inc_rename :rename {:default (vim.fn.expand "<cword>")}))
  (map! [n (:buffer bufnr)] :<leader>ca 'vim.lsp.buf.code_action)
  (map! [n (:buffer bufnr)] :gr 'vim.lsp.buf.references)
  (map! [n (:buffer bufnr)] :<leader>f '(vim.lsp.buf.format {:async true}))

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

; nvim-cmp setup
(local cmp (require :cmp))
(let [cmp_autopairs (require :nvim-autopairs.completion.cmp)]
  (cmp.event:on :confirm_done (cmp_autopairs.on_confirm_done {:map_char {:tex ""}})))

(cmp.setup {:mapping {:<C-p>   (cmp.mapping.select_prev_item)
                      :<C-n>   (cmp.mapping.select_next_item)
                      :<TAB>   (cmp.mapping.select_next_item)
                      :<S-TAB> (cmp.mapping.select_prev_item)
                      :<CR>    (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace})}
            :sources [{:name :nvim_lsp}
                      {:name :path}
                      {:name :buffer}
                      {:name :latex_symbols}]})

(cmp.setup.filetype :gitcommit {:sources (cmp.config.sources [{:name :cmp_git}
                                                              {:name :buffer}])})

(each [_ v (ipairs ["/" "?"])]
  (cmp.setup.cmdline v {:mapping (cmp.mapping.preset.cmdline)
                        :sources [{:name :buffer}]}))

(cmp.setup.cmdline ":" {:mapping (cmp.mapping.preset.cmdline)
                        :sources [{:name :path}
                                  {:name :cmdline}]})

(setup :cmp_git)

(reqcall :lspsaga :init_lsp_saga)

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
               null_ls.builtins.formatting.isort]]
  (null_ls.setup {:sources sources
                  :diagnostics_format "[#{s}] #{c}: #{m}"}))

(setup :lsp_lines {})
(vim.diagnostic.config {:virtual_text false})
