(import-macros {: augroup! : exec : set! : setup : reqcall : map!} :macros)

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

(reqcall :lspsaga :init_lsp_saga)

(setup :mason)
(setup :mason-lspconfig {:automatic_installation true})
(setup :mason-tool-installer {:auto_update true
                              :ensure_installed [:flake8
                                                 :isort
                                                 :stylua]})

(let [signs {:Error :E
             :Warn :W
             :Hint :H
             :Info :I}]
  (each [type icon (pairs signs)]
    (let [hl (.. :DiagnosticSign type)]
      (vim.fn.sign_define hl {:text icon
                              :texthl hl
                              :numhl hl}))))


;; lsp helpers
(local configured_ls [])

(let [lsputil (require :lspconfig.util)]
  (lsputil.add_hook_before lsputil.on_setup
                           (fn [config] (tset configured_ls config.name true))))

(macro setup_ls [lsp options]
  (local ls_options {:on_attach 'on_attach
                     :capabilities 'capabilities})
  (when (~= options nil)
    (each [k (pairs options)]
      (tset ls_options k (. options k))))

  `(if (. configured_ls ,lsp)
     (vim.notify (.. ,lsp " is set up several times") vim.log.levels.WARN)
     ((. (. (require :lspconfig) ,lsp) :setup) ,ls_options)))

;; init servers with manual configuration
(let [schemastore (require :schemastore)]
  (setup_ls :jsonls {:settings {:json {:validate {:enable true}
                                       :schemas (schemastore.json.schemas)}}})

  (setup_ls :yamlls {:settings {:yaml {:schemaStore {:enable true}}}})

  (setup_ls :taplo {:settings {:toml {:schemas (schemastore.json.schemas)}}}))


(setup :lua-dev {})

;; setup installed ls and a set of ensured servers with default configuration
(let [servers (vim.tbl_deep_extend
                :force
                [:pyright :jdtls :clangd :lemminx :tsserver :vimls :sumneko_lua]
                (reqcall :mason-lspconfig :get_installed_servers))]
  (each [_ lsp (ipairs servers)]
    (when (not (. configured_ls lsp))
      (setup_ls lsp))))

(local null_ls (require :null-ls))
(let [sources [null_ls.builtins.diagnostics.flake8
               null_ls.builtins.formatting.isort
               null_ls.builtins.formatting.stylua]]
  (null_ls.setup {:sources sources
                  :diagnostics_format "[#{s}] #{c}: #{m}"}))
