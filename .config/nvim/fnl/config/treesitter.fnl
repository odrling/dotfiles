(import-macros {: reqcall : setup : exec : command!} :macros)

(setup :nvim-treesitter.configs {:highlight {:enable true
                                             :additional_vim_regex_highlighting false}
                                 :auto_install true
                                 :ensure_installed [:fennel :lua :python :java :c :cpp :rust]
                                 :incremental_selection {:enable true}
                                 :textobjects {:select {:enable true
                                                        ; Automatically jump forward to textobj
                                                        :lookahead true
                                                        :keymaps {:af "@function.outer"
                                                                  :if "@function.inner"
                                                                  :ac "@class.outer"
                                                                  :ic "@class.inner"}}}
                                 :endwise {:enable true}
                                 :autotag {:enable true}
                                 :rainbow {:enable true
                                           :extended_mode true}
                                 :yati {:enable true}})

(fn force_reinstall_parser []
  (local lang (reqcall :nvim-treesitter.parsers :get_buf_lang))
  (exec [[:TSInstall! lang]]))

(command! [] :TSReload 'force_reinstall_parser)
