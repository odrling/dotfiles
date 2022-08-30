(import-macros {: setup : map! : reqcall} :macros)

(local hosts (require :gitlinker.hosts))
(setup :gitlinker {:mappings nil
                   :callbacks {
                               :git.odrling.xyz hosts.get_gitea_type_url
                               :git.rhiobet.sh hosts.get_gitlab_type_url}})

(local actions (require :gitlinker.actions))
(map! [n] "<leader>y" #(reqcall :gitlinker :get_buf_range_url :n {:action_callback actions.copy_to_clipboard}))
(map! [v] "<leader>y" #(reqcall :gitlinker :get_buf_range_url :v {:action_callback actions.copy_to_clipboard}))
