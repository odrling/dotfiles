(import-macros {: setup : reqcall} :macros)
(import-macros {: merge} :core_macros)

(setup :mason {:ui {:border :rounded}
               :PATH :append
               :pip {:upgrade_pip true}})

(local M {})

;; setup installed ls and a set of ensured servers with default configuration
(fn M.setup_installed_servers [...]
  (let [servers (merge [...] (reqcall :mason-lspconfig :get_installed_servers))]
    (each [_ lsp (ipairs servers)]
      ((require :config.lsp.setup_ls) lsp {} true))))

(fn M.ensure_tools [...]
  (setup :mason-tool-installer {:auto_update true
                                :ensure_installed [$...]}))

:return M
