(import-macros {: augroup! : set! : g!} :macros)

(local fc {})
(tset fc ".*" {:takeover :never})
(tset fc "https://github\\.com/.*" {:takeover :once
                                    :priority 1})

(set vim.g.firenvim_config {:globalSettings {:alt :all}
                            :localSettings fc})

(augroup! :firenvim
          [[BufEnter] :github.com_* #(set! filetype :markdown)])
