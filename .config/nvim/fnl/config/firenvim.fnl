(import-macros {: augroup! : set! : g!} :macros)

(local MIN_LINES 5)
(local MIN_COLUMNS 66)

(macro firenvim_config [...]
  (local entries {".*" {:takeover :never
                        :priority 0
                        :cmdline :none}})
  (local filetypes {})
  (local aucmds [])
  (each [_ entry (pairs [...])]
    (let [(domain filetype takeover) (unpack entry)]
      (let [takeover (if (= takeover nil) :always takeover)
            regex (.. "https://[^/]*" (string.gsub domain "[.]" "\\.") "/.*")
            glob (.. domain "_*")]
        (tset entries regex {:takeover takeover
                             :priority 1
                             :cmdline :none})
        (when (~= filetype nil)
          (tset filetypes domain filetype)))))
  `(do
     (set ,(sym :vim.g.firenvim_config) {:localSettings ,entries})
     (when vim.g.started_by_firenvim
        (augroup! :firenvim
               [[BufEnter] * (fn []
                               (if (< vim.o.lines MIN_LINES)
                                 (vim.defer_fn #(set! lines MIN_LINES) 50))
                               (if (< vim.o.columns MIN_COLUMNS)
                                 (vim.defer_fn #(set! columns MIN_COLUMNS) 50))
                               (local expected_domain# (string.gsub (vim.fn.expand "%:t") "_.*" ""))
                               (local filetype# (. ,filetypes expected_domain#))
                               (when (~= filetype# nil)
                                 (tset vim.bo :filetype filetype#)))]))))



(firenvim_config (:github.com :markdown)
                 (:discord.com :markdown :never))
