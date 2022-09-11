(import-macros {: reqcall : map! : exec : augroup! : set!} :macros)

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

(let [signs {:Error :E
             :Warn :W
             :Hint :H
             :Info :I}]
  (each [type icon (pairs signs)]
    (let [hl (.. :DiagnosticSign type)]
      (vim.fn.sign_define hl {:text icon
                              :texthl hl
                              :numhl hl}))))

(set! completeopt "menuone,noselect")

; add additional capabilities supported by nvim-cmp
(var capabilities (vim.lsp.protocol.make_client_capabilities))
(let [cmp_nvim_lsp (require :cmp_nvim_lsp)]
  (set capabilities (cmp_nvim_lsp.update_capabilities capabilities)))

; Neovim does not currently include built-in snippets.
; vscode-json-language-server only provides completions when snippet support
; is enabled)
(set capabilities.textDocument.completion.completionItem.snippetSupport true)

;; lsp helpers
(local configured_ls [])

(let [lsputil (require :lspconfig.util)]
  (lsputil.add_hook_before lsputil.on_setup
                           (fn [config] (tset configured_ls config.name true))))

(fn setup_ls [lsp options ignore_if_configured]
  (local ls_options {:on_attach on_attach
                     :capabilities capabilities})
  (when (~= options nil)
    (set ls_options.settings options))

  (if (. configured_ls lsp)
    (if (not ignore_if_configured)
      (vim.notify (.. lsp " is set up several times") vim.log.levels.WARN))
    ((. (. (require :lspconfig) lsp) :setup) ls_options)))
