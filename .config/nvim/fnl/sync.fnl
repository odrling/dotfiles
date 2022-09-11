(import-macros {: command! : reqcall : exec : augroup! : g!} :macros)

(fn sync []
 (reqcall :tangerine.api.compile :all)
 (exec [[:source (.. (vim.fn.stdpath :config) "/lua/config/packer.lua")]])
 (reqcall :packer :sync))

(command! [] :Sync sync)

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


(when (. _G :tangerine.nvim_bootstrap)
  (set _G.bootstraping_packer true)
  (fn load_all_packages_once []
    (when _G.bootstraping_packer
      (vim.cmd.packloadall {:bang true})
      (set _G.bootstraping_packer false)))

  (augroup! :packer-bootstrap
            [[User] PackerComplete 'load_all_packages_once])

  (require :config.packer)
  (reqcall :packer :sync))
