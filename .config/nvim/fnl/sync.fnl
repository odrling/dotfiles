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

(set _G.bootstraping_packer true)
(fn load_all_packages_once []
  (when _G.bootstraping_packer
    (vim.cmd.packloadall)
    (set _G.bootstraping_packer false)))

(augroup! :packer-bootstrap
          [[User] PackerComplete #(reqcall :packer :compile)]
          [[User] PackerCompileDone 'load_all_packages_once])

(require :config.packer)
(reqcall :packer :install)
(pcall vim.cmd.luafile _G.packer_compile_path)
