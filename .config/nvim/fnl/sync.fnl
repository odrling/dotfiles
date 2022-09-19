(import-macros {: command! : reqcall : exec : augroup! : g!} :macros)

(fn recompile []
  (reqcall :tangerine.api.compile :all)
  (exec [[:source (.. (vim.fn.stdpath :config) "/lua/config/packer.lua")]]))

(fn sync []
  (recompile)
  (reqcall :packer :sync))

(fn install []
  (recompile)
  (reqcall :packer :clean)
  (reqcall :packer :install))

(command! [] :Sync sync)
(command! [] :Install install)

(local dotdir (vim.fn.expand "$HOME/.dots"))
(local dotroot (vim.fn.expand "$HOME"))

(fn is_dots_file [file]
  (if (and (> (length file) 0) (vim.fn.filereadable file))
      (do (vim.fn.system ["git" "--git-dir" dotdir "--work-tree" dotroot "ls-files" "--error-unmatch" file])
          (= vim.v.shell_error 0))
      false))

(augroup! :dots
          [[BufEnter] * #(let [file (vim.fn.expand "%:p")]
                           (when (is_dots_file file)
                             (set vim.env.GIT_DIR dotdir)
                             (set vim.env.GIT_WORK_TREE dotroot)))])


(augroup! :packer
          [[BufWritePost] packer.fnl (fn []
                                       (reqcall :tangerine.api.compile :buffer)
                                       (exec [[:source (.. (vim.fn.stdpath :config) "/lua/config/packer.lua")]])
                                       (reqcall :packer :compile))])

;; set packer compile path
(tset _G :packer_compile_path (.. (vim.fn.stdpath :cache) "/packer_compiled.lua"))

(require :config.packer)

(fn get_plugins_path []
  (icollect [_ plug (pairs (or _G.packer_plugins []))]
            plug.path))


(fn update_packages []
  (local plugin_utils (require :packer.plugin_utils))
  (let [(opt_plugins start_plugins) (plugin_utils.list_installed_plugins)
        plugins                     (get_plugins_path)]
    (local installed_plugins [])
    (each [path _ (pairs opt_plugins)]
      (table.insert installed_plugins path))
    (each [path _ (pairs start_plugins)]
      (table.insert installed_plugins path))

    (table.sort plugins)
    (table.sort installed_plugins)

    (var missing (~= (# plugins) (# installed_plugins)))
    (when (not missing)
      (for [i 1 (# plugins)]
        (when (~= (. plugins i) (. installed_plugins i))
          (set missing true))))

    (if missing
      (do
        (augroup! :packer-bootstrap
                  [[User] PackerComplete #(reqcall :packer :compile)]
                  [[User] PackerCompileDone #(set _G.updated_packer_plugins true)])
        (reqcall :packer :install))
      (do (set _G.updated_packer_plugins true)
          (vim.cmd.doautocmd {:args [:User :PackerComplete]})))))


(if _G.config_bootstraping
  (update_packages)
  (do
    (augroup! :packer-bootstrap
              [[User] PackerCompileDone 'update_packages])
    (if _G.tangerine_recompiled_packer
      (reqcall :packer :compile)
      (do (vim.cmd.luafile _G.packer_compile_path)
          (update_packages)))
    (vim.fn.wait -1 #(~= _G.updated_packer_plugins nil))
    (vim.cmd.packloadall)))
