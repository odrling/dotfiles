(import-macros {: setup : reqcall} :macros)
(import-macros {: merge} :core_macros)

(local setup_ls (require :config.lsp.setup_ls))
(local mason_utils (require :config.lsp.mason))

(setup :lua-dev {})

;; init servers with manual configuration
(local schemastore (require :schemastore))

(setup_ls :jsonls {:settings {:json {:validate {:enable true}
                                     :schemas (schemastore.json.schemas)}}})

(setup_ls :yamlls {:settings {:yaml {:schemaStore {:enable true}}}})

(setup_ls :taplo {:settings {:toml {:schemas (schemastore.json.schemas)}}})

(setup_ls :jdtls {:init_options {:extendedClientCapabilities {:progressReportProvider false}}})

(local globals [])
(when vim.env.MPV_LUA (table.insert globals :mp))
(when vim.env.AEGISUB_LUA (table.insert globals :aegisub))
(setup_ls :sumneko_lua {:Lua {:diagnostics {:globals globals}}})

(mason_utils.setup_installed_servers :pyright :clangd :lemminx :tsserver :vimls :sumneko_lua)
