(import-macros {: reqcall : setup : exec : command!} :macros)

(setup :nvim-treesitter.configs {:highlight {:enable true
                                             :additional_vim_regex_highlighting false}
                                 :auto_install true
                                 :ensure_installed [:fennel :lua :python :java :c :cpp :rust :markdown :markdown_inline]
                                 :incremental_selection {:enable true}
                                 :textobjects {:select {:enable true
                                                        ; Automatically jump forward to textobj
                                                        :lookahead true
                                                        :keymaps {:af "@function.outer"
                                                                  :if "@function.inner"
                                                                  :ac "@class.outer"
                                                                  :ic "@class.inner"}}}
                                 :endwise  {:enable true}
                                 :autotag  {:enable true}
                                 :refactor {:enable true
                                            :highlight_definitions {:enable false}
                                            :highlight_current_scope {:enable false}
                                            :navigation {:enable true
                                                         :keymaps {:goto_definition_lsp_fallback "gd"
                                                                   :goto_next_usage "<a-n>"
                                                                   :goto_previous_usage "<a-N>"}}
                                            :smart_rename {:enable true
                                                           :keymaps {:smart_rename "<leader>r"}}}
                                 :context_commentstring {:enable true
                                                         :enable_autocmd false}
                                 :rainbow  {:enable true
                                            :extended_mode true}
                                 :indent   {:enable true
                                            :disable [:python]}})

(fn force_reinstall_parser []
  (local lang (reqcall :nvim-treesitter.parsers :get_buf_lang))
  (exec [[:TSInstall! lang]]))

(command! [] :TSReload 'force_reinstall_parser)
