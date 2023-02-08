(import-macros {: augroup! : setup : reqcall} :macros)

(local nvim_dir (vim.fn.stdpath :config))

(augroup! :fennel_init_lua
          [[BufWritePost] :init.fnl #(reqcall :tangerine.api.compile :dir (.. nvim_dir "/initfnl") nvim_dir)])

(setup :tangerine {:compiler {:verbose false
                              :hooks [:onsave :oninit]}
                   :custom [[(.. nvim_dir "/ftplugin") (.. nvim_dir "/ftplugin")]]})
