(import-macros {: setup : map! : reqcall} :macros)

(vim.cmd.packadd :auto-session)
(set vim.o.sessionoptions "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal")

(let [suppress_dirs (if vim.env.NVIM_AUTOSAVE_SESSION nil ["~/" "~/git"])
      allowed_dirs (if vim.env.NVIM_AUTOSAVE_SESSION nil ["~/git/*"])]
  (setup :auto-session {:auto_session_allow_dirs ["~/git/*"]
                        :auto_session_suppress_dirs suppress_dirs
                        :log_level vim.log.levels.DEBUG
                        :auto_session_use_git_branch true}))

(map! [n] :<leader>S #(reqcall :session-lens :search_session))
