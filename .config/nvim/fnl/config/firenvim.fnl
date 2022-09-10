(import-macros {: augroup! : set! : g!} :macros)

(local fc {})
(tset fc "https://discord\\.com/.*" {:takeover :never
                                     :priority 1})
(tset fc "https://web\\.whatsapp\\.com/.*" {:takeover :never
                                            :priority 1})

(set vim.g.firenvim_config {:globalSettings {:alt :all}
                            :localSettings fc})

(augroup! :firenvim
          [[BufEnter] :github.com_* #(set! filetype :markdown)])
