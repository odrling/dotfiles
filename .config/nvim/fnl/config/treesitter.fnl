(import-macros {: setup : augroup!} :macros)

(setup :nvim-treesitter.configs {:highlight {:enable true
                                             :additional_vim_regex_highlighting false}
                                 :incremental_selection {:enable true}
                                 :textobjects {:select {:enable true
                                                        ; Automatically jump forward to textobj
                                                        :lookahead true
                                                        :keymaps {:af "@function.outer"
                                                                  :if "@function.inner"
                                                                  :ac "@class.outer"
                                                                  :ic "@class.inner"}}}
                                 :playground {:enable true
                                              :updatetime 25}
                                 :endwise {:enable true}
                                 :autotag {:enable true}
                                 :yati {:enable true}})


(fn install_current_filetype []
  (local install_mod (require "nvim-treesitter.install"))
  (pcall install_mod.ensure_installed vim.bo.filetype))

(augroup! :treesitter [[BufEnter] * 'install_current_filetype])
