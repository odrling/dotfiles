(import-macros {: setup : augroup! : reqcall} :macros)
(local pack :tangerine)

(lambda bootstrap [url]
  (local name (url:gsub ".*/" ""))
  (local path (.. (vim.fn.stdpath :data) "/site/pack/" pack "/start/" name))
  (if (= (vim.fn.isdirectory path) 0)
    (do (set _G.config_bootstraping true)
        (print (.. name ": installing in data dir..."))

        (vim.fn.system [:git "clone" "--depth" "1" url path])
        (vim.cmd.redraw)
        (print (.. name ": finished installing"))
        (vim.cmd.packadd name)
        true)
    false))

(macro ghstrap [repo]
  (local url (.. "https://github.com/" repo))
  `(bootstrap ,url))

(var BOOTSTRAP (~= vim.env.BOOTSTRAP_NEOVIM nil))

(let [lazypath (.. (vim.fn.stdpath :data) "/lazy/lazy.nvim")]
  (when (not (vim.loop.fs_stat lazypath))
    (vim.fn.system ["git" "clone"
                    "--filter=blob:none"
                    "https://github.com/folke/lazy.nvim.git"
                    "--branch=stable"
                    lazypath])

    (set BOOTSTRAP true))

  (vim.opt.rtp:prepend lazypath))

(when BOOTSTRAP
  (setup :lazy 
    [
     {1 :udayvir-singh/tangerine.nvim
      :lazy false
      :priority 200
      :config #(do (setup :tangerine {:compiler {:verbose false
                                                 :hooks [:onsave :oninit]}})
                   (vim.cmd.quitall {:bang true}))}]))


(require :settings)
(require :before)
(require :sync)
(require :profiling)
