(import-macros {: command! : reqcall : exec : augroup! : g!} :macros)

(fn recompile []
  (reqcall :tangerine.api.compile :all)
  (exec [[:source (.. (vim.fn.stdpath :config) "/lua/config/packer.lua")]]))

(fn sync []
  (recompile)
  (reqcall :packer :sync))

(fn upgrade []
  (recompile)
  (reqcall :packer :sync {:nolockfile true}))

(fn install []
  (recompile)
  (reqcall :packer :clean)
  (reqcall :packer :install))

(fn sync_quit []
  (augroup! :packer-auto-update-steps
            [[User] PackerCompileDone #(vim.cmd :qa)])
  (sync))

(command! [] :Sync sync)
(command! [] :SyncQuit sync_quit)
(command! [] :Upgrade upgrade)
(command! [] :Install install)

(local dotdir (vim.fn.expand "$HOME/.dots"))
(local dotroot (vim.fn.expand "$HOME"))

(lambda is_dots_file [file]
  (if (and (> (length file) 0) (vim.fn.filereadable file))
      (do (vim.fn.system ["git" "--git-dir" dotdir "--work-tree" dotroot "ls-files" "--error-unmatch" file])
          (= vim.v.shell_error 0))
      false))

(lambda is_dots_dir [dir]
  (vim.fn.system ["git" "--git-dir" dotdir "--work-tree" dotroot "ls-files" "--error-unmatch" dir]
      (= vim.v.shell_error 0)))

(fn set_git_dir []
  (set vim.env.GIT_DIR dotdir)
  (set vim.env.GIT_WORK_TREE dotroot))

(fn unset_git_dir []
  (set vim.env.GIT_DIR nil)
  (set vim.env.GIT_WORK_TREE nil))

(let [cwd (vim.fn.getcwd)]
  (when (is_dots_dir cwd)
      (set_git_dir)))

(augroup! :dots
          [[BufReadPre] * #(let [file (vim.fn.expand "%:p")]
                             (if (is_dots_file file)
                               (set_git_dir)
                               (unset_git_dir)))])


(augroup! :packer
          [[BufWritePost] packer.fnl (fn []
                                       (reqcall :tangerine.api.compile :buffer)
                                       (exec [[:source (.. (vim.fn.stdpath :config) "/lua/config/packer.lua")]])
                                       (reqcall :packer :compile))])

;; set packer compile path
(tset _G :packer_compile_path (.. (vim.fn.stdpath :cache) "/packer_compiled.lua"))

(require :config.packer)

(if _G.tangerine_recompiled_packer
  (reqcall :packer :sync)
  (vim.cmd.luafile _G.packer_compile_path))
