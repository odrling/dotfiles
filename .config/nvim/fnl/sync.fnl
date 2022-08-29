(import-macros {: command! : reqcall : exec : augroup! : g!} :macros)

(command! [] :Sync (fn []
                     (reqcall :tangerine.api.compile :all)
                     (exec [[:source (.. (vim.fn.stdpath :config) "/lua/config/packer.lua")]])
                     (reqcall :packer :sync)))


(local dotdir (vim.fn.expand "$HOME/.dots"))
(local dotroot (vim.fn.expand "$HOME"))

(fn is_dots_file [file]
  (if (vim.fn.filereadable file)
      (do (vim.fn.system ["git" "--git-dir" dotdir "--work-tree" dotroot "ls-files" "--error-unmatch" file])
          (~= vim.v.shell_error 0))
      false))

(augroup! :dots
          [[BufEnter] * #(let [file (vim.fn.expand "%:p")]
                           (when (is_dots_file file)
                             (set vim.env.GIT_DIR dotdir)
                             (set vim.env.GIT_WORK_TREE dotroot)))])
