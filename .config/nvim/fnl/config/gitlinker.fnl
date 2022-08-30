(import-macros {: setup : map! : reqcall} :macros)

(local hosts (require :gitlinker.hosts))
(setup :gitlinker {:mappings "<leader>y"
                   :callbacks {
                               :git.odrling.xyz hosts.get_gitea_type_url
                               :git.rhiobet.sh hosts.get_gitlab_type_url}})
