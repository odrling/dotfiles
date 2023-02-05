(import-macros {: setup : map! : reqcall} :macros)

(set vim.o.sessionoptions "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal")

(let [suppress_dirs (if vim.env.NVIM_AUTOSAVE_SESSION nil ["~/"])
      allowed_dirs (if vim.env.NVIM_AUTOSAVE_SESSION nil ["~/git/*"])]
  (setup :auto-session {:auto_session_allow_dirs allowed_dirs
                        :auto_session_suppress_dirs suppress_dirs
                        :auto_restore_enabled false
                        :log_level vim.log.levels.DEBUG}))

(map! [n] :<leader>sl "<cmd>RestoreSession<cr>")
(map! [n] :<leader>S #(reqcall :session-lens :search_session))
