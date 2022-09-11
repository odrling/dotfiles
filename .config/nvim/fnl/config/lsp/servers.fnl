(import-macros {: setup : reqcall} :macros)
(import-macros {: merge} :core_macros)

(local setup_ls (require :config.lsp.setup_ls))
(local mason_utils (require :config.lsp.mason))

(setup :lua-dev {})

;; init servers with manual configuration
(let [schemastore (require :schemastore)]
  (setup_ls :jsonls {:settings {:json {:validate {:enable true}
                                       :schemas (schemastore.json.schemas)}}})

  (setup_ls :yamlls {:settings {:yaml {:schemaStore {:enable true}}}})

  (setup_ls :taplo {:settings {:toml {:schemas (schemastore.json.schemas)}}}))

(mason_utils.setup_installed_servers :pyright :jdtls :clangd :lemminx :tsserver :vimls :sumneko_lua)
