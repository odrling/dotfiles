(import-macros {: setup : reqcall : map!} :macros)

(local find_command ["fd" "--type" "f" "--strip-cwd-prefix" "--hidden"])
(when vim.env.FD_NO_IGNORE_VCS
                    (table.insert find_command "--no-ignore-vcs"))

(setup :telescope {:pickers {:find_files {:find_command find_command}}})

(map! [n] "<leader>b" #(reqcall :telescope.builtin :buffers {:sort_mru true
                                                             :ignore_current_buffer true}))
