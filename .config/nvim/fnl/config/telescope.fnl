(import-macros {: map!} :macros)

(local telescope (require :telescope))
(local frecency_sorter (require :config.telescope.frecency_sorter))

(local find_command ["fd" "--type" "f" "--strip-cwd-prefix" "--hidden"])
(when vim.env.FD_NO_IGNORE_VCS
                    (table.insert find_command "--no-ignore-vcs"))

(telescope.setup {:pickers {:find_files {:find_command find_command}}
                  :extensions {:frecency {:default_workspace :CWD}
                               :zf-native {:file {:enable false}}}
                  :defaults {:file_sorter frecency_sorter}})

(telescope.load_extension :zf-native)
(telescope.load_extension :notify)
(telescope.load_extension :frecency)
