(import-macros {: setup : reqcall : map!} :macros)

(local frecency_sorter (require :config.telescope.frecency_sorter))

(local find_command ["fd" "--type" "f" "--strip-cwd-prefix" "--hidden"])
(when vim.env.FD_NO_IGNORE_VCS
                    (table.insert find_command "--no-ignore-vcs"))

(setup :telescope {:pickers {:find_files {:find_command find_command}}}
                  :extensions {:frecency {:default_workspace :CWD}
                               :zf-native {:file {:enable false}}}
                  :defaults {:file_sorter frecency_sorter})

(reqcall :telescope :load_extension :zf-native)
(reqcall :telescope :load_extension :frecency)

(map! [n] "<leader>b" #(reqcall :telescope.builtin :buffers {:sort_mru true
                                                             :ignore_current_buffer true}))
