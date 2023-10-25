(import-macros {: setup : map! : reqcall} :macros)

(local hosts (require :gitlinker.hosts))
(fn get_cgit_stripped_type_url [url_data]
  (.. "https://" url_data.host "/" url_data.repo "/tree/" url_data.file "?id="
      url_data.rev "#n" url_data.lstart))

(fn get_cgit_type_url [url_data]
  (.. "https://" url_data.host "/" url_data.repo ".git/tree/" url_data.file "?id="
      url_data.rev "#n" url_data.lstart))

(setup :gitlinker {:mappings "<leader>y"
                   :callbacks {
                               :git.odrling.xyz get_cgit_stripped_type_url
                               :git.kernel.org get_cgit_type_url
                               :git.japan7.bde.enseeiht.fr hosts.get_gitea_type_url
                               :git.rhiobet.sh hosts.get_gitlab_type_url
                               :git.inpt.fr hosts.get_gitlab_type_url}})
