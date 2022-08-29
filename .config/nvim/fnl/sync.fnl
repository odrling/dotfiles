(import-macros {: command! : reqcall} :macros)

(command! [] :Sync (fn []
                     (reqcall :tangerine.api.compile :all)
                     (reqcall :packer :sync)))
