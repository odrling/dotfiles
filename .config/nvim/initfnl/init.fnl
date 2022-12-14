(import-macros {: setup : augroup! : reqcall} :macros)
(local pack :packer)

(lambda bootstrap [url]
  (local name (url:gsub ".*/" ""))
  (local path (.. (vim.fn.stdpath :data) "/site/pack/" pack "/start/" name))
  (when (= (vim.fn.isdirectory path) 0)
    (set _G.config_bootstraping true)
    (print (.. name ": installing in data dir..."))

    (vim.fn.system [:git "clone" "--depth" "1" url path])
    (vim.cmd.redraw)
    (print (.. name ": finished installing"))
    (vim.cmd.packadd name)))

(macro ghstrap [repo]
  (local url (.. "https://github.com/" repo))
  `(bootstrap ,url))

(ghstrap :udayvir-singh/tangerine.nvim)
(ghstrap :lewis6991/impatient.nvim)
(ghstrap :wbthomason/packer.nvim)
(ghstrap :projekt0n/github-nvim-theme)
(ghstrap :rmagatti/auto-session)

(require :impatient)

(local nvim_dir (vim.fn.stdpath :config))

(augroup! :fennel_init_lua
          [[BufWritePost] :init.fnl #(reqcall :tangerine.api.compile :dir (.. nvim_dir "/initfnl") nvim_dir)])

(setup :tangerine {:compiler {:verbose false
                              :hooks [:onsave]}
                   :custom [[(.. nvim_dir "/ftplugin") (.. nvim_dir "/ftplugin")]]})

(set _G.tangerine_recompiled_packer (> (# (icollect [_ v (ipairs (reqcall :tangerine.vim.hooks :run))]
                                                    (if (= v "config/packer.fnl") v nil)))
                                       0))


(require :profiling)
(require :settings)
(require :before)
(require :sync)
