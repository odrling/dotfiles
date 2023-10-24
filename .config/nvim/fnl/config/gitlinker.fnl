(import-macros {: setup : map! : reqcall} :macros)

(local hosts (require :gitlinker.hosts))
(setup :gitlinker {:mappings "<leader>y"
                   :callbacks {
                               :git.odrling.xyz hosts.get_cgit_type_url
                               :git.kernel.org hosts.get_cgit_type_url
                               :git.japan7.bde.enseeiht.fr hosts.get_gitea_type_url
                               :git.rhiobet.sh hosts.get_gitlab_type_url
                               :git.inpt.fr hosts.get_gitlab_type_url}})
