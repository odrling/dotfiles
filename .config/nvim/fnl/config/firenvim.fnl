(import-macros {: augroup! : set! : g!} :macros)

(when (~= vim.g.started_by_firenvim nil)

  (local fc {})
  (tset fc ".*" {:takeover :never})
  (tset fc "https://github\\.com/.*" {:takeover :once
                                        :priority 1})

  (set vim.g.firenvim_config {:globalSettings {:alt :all}
                              :localSettings fc})

  (local min_lines 5)
  (augroup! :firenvim
            [[BufEnter] * #(if (< vim.o.lines min_lines)
                               (vim.defer_fn #(set! lines min_lines) 50))]
            [[BufEnter] :github.com_* #(set! filetype :markdown)]
            [[BufEnter] :discord.com_* #(set! filetype :markdown)]))
