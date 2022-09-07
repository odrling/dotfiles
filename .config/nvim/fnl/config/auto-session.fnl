(import-macros {: setup : map! : reqcall} :macros)

(setup :auto-session {:auto_session_allow_dirs ["~/git/*"]
                      :auto_session_suppress_dirs ["~/" "~/git"]})

(map! [n] :<leader>S #(reqcall :session-lens :search_session))
