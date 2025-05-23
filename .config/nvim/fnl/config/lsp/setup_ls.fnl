(import-macros {: reqcall : map! : exec : augroup! : set!} :macros)

(local original_open_float vim.diagnostic.open_float)

(fn on_attach [client bufnr]
  (tset vim.lsp.handlers :textDocument/publishDiagnostics
    (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics {:virtual_text false}))

  (map! [n (:buffer bufnr)] :<leader>l #(: (require :config.hydras.lsp) :activate))
  (map! [n (:buffer bufnr)] :<leader>L #(set vim.diagnostic.open_float (if (reqcall :lsp_lines :toggle)
                                                                         (fn [] nil)
                                                                         original_open_float)))

  (map! [n (:buffer bufnr)] :<leader>D "<cmd>Telescope diagnostics<CR>")
  (map! [n (:buffer bufnr)] :gD 'vim.lsp.buf.declaration)
  (map! [n (:buffer bufnr)] :K 'vim.lsp.buf.hover)
  (map! [n (:buffer bufnr)] :gi 'vim.lsp.buf.implementation)
  (map! [n (:buffer bufnr)] :<C-k> 'vim.lsp.buf.signature_help)
  (map! [n (:buffer bufnr) :expr] :<leader>r #(.. ":IncRename " (vim.fn.expand "<cword>")))
  (map! [n (:buffer bufnr)] :<leader>ca 'vim.lsp.buf.code_action)
  (map! [n (:buffer bufnr)] :gr 'vim.lsp.buf.references)
  (map! [n (:buffer bufnr)] :<leader>f '(vim.lsp.buf.format {:async true}))

  (when client.server_capabilities.documentHighlightProvider
    (exec [[:hi! "LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow"]
           [:hi! "LspReferenceText cterm=bold ctermbg=red guibg=LightYellow"]
           [:hi! "LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow"]])
    ;close enough
    (augroup! :lsp_document_highlight
              [[CursorHold CursorHoldI] * 'vim.lsp.buf.document_highlight bufnr]
              [[CursorMoved] * 'vim.lsp.buf.clear_references bufnr]))

  (let [signs {:Error :E
               :Warn :W
               :Hint :H
               :Info :I}]
    (each [type icon (pairs signs)]
      (let [hl (.. :DiagnosticSign type)]
        (vim.fn.sign_define hl {:text icon
                                :texthl hl
                                :numhl hl})))))

(set! completeopt "menuone,noselect")

; add additional capabilities supported by nvim-cmp
(var capabilities (vim.lsp.protocol.make_client_capabilities))
(let [cmp_nvim_lsp (require :cmp_nvim_lsp)]
  (set capabilities (cmp_nvim_lsp.default_capabilities capabilities)))

; Neovim does not currently include built-in snippets.
; vscode-json-language-server only provides completions when snippet support
; is enabled)
(set capabilities.textDocument.completion.completionItem.snippetSupport true)

;; lsp helpers
(local configured_ls [])

(fn setup_ls [lsp options ignore_if_configured]
  (local ls_options {:on_attach on_attach
                     :capabilities capabilities})
  (when (~= options nil)
    (each [k v (pairs options)]
      (tset ls_options k v)))

  (if (. configured_ls lsp)
    (if (not ignore_if_configured)
      (vim.notify (.. lsp " is set up several times") vim.log.levels.WARN))
    (do ((. (. (require :lspconfig) lsp) :setup) ls_options)
        (tset configured_ls lsp true))))

:return {: setup_ls : on_attach}
