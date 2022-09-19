(import-macros {: setup : map! : reqcall} :macros)

(vim.cmd.packadd :auto-session)
(set vim.o.sessionoptions "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal")

(setup :auto-session {:auto_session_allow_dirs ["~/git/*"]
                      :auto_session_suppress_dirs ["~/" "~/git"]
                      :log_level vim.log.levels.DEBUG})

(map! [n] :<leader>S #(reqcall :session-lens :search_session))
