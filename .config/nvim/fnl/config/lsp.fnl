(import-macros {: augroup! : exec : set! : setup : reqcall : map!} :macros)
(import-macros {: merge} :core_macros)

(local setup_ls (require :config.lsp.setup_ls))

(set! completeopt "menuone,noselect")

(let [signs {:Error :E
             :Warn :W
             :Hint :H
             :Info :I}]
  (each [type icon (pairs signs)]
    (let [hl (.. :DiagnosticSign type)]
      (vim.fn.sign_define hl {:text icon
                              :texthl hl
                              :numhl hl}))))


(setup :mason)
(setup :mason-lspconfig {:automatic_installation true})

;; init servers with manual configuration
(let [schemastore (require :schemastore)]
  (setup_ls :jsonls {:settings {:json {:validate {:enable true}
                                       :schemas (schemastore.json.schemas)}}})

  (setup_ls :yamlls {:settings {:yaml {:schemaStore {:enable true}}}})

  (setup_ls :taplo {:settings {:toml {:schemas (schemastore.json.schemas)}}}))

(setup :lua-dev {})

;; setup installed ls and a set of ensured servers with default configuration
(let [servers (merge
                [:pyright :jdtls :clangd :lemminx :tsserver :vimls :sumneko_lua]
                (reqcall :mason-lspconfig :get_installed_servers))]
  (each [_ lsp (ipairs servers)]
    (setup_ls lsp {} true)))

;; linter/formatter setup
(setup :mason-tool-installer {:auto_update true
                              :ensure_installed [:flake8
                                                 :isort
                                                 :stylua]})
(local null_ls (require :null-ls))
(let [sources [null_ls.builtins.diagnostics.flake8
               null_ls.builtins.formatting.isort
               null_ls.builtins.formatting.stylua]]
  (null_ls.setup {:sources sources
                  :diagnostics_format "[#{s}] #{c}: #{m}"}))
