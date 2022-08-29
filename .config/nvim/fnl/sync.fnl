(import-macros {: command! : reqcall : exec} :macros)

(command! [] :Sync (fn []
                     (reqcall :tangerine.api.compile :all)
                     (exec [[:source (.. (vim.fn.stdpath :config) "/lua/config/packer.lua")]])
                     (reqcall :packer :sync)))
