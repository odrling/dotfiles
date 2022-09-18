(import-macros {: map!} :macros)

(local telescope (require :telescope))

(local find_command ["fd" "--type" "f" "--strip-cwd-prefix" "--hidden"])
(when vim.env.FD_NO_IGNORE_VCS
                    (table.insert find_command "--no-ignore-vcs"))
(telescope.setup {:pickers {:find_files {:find_command find_command}}
                  :extensions {:frecency {:default_workspace :CWD}}})

(telescope.load_extension :zf-native)
(telescope.load_extension :notify)
(telescope.load_extension :frecency)

(map! [n] :<leader><leader> "<cmd>Telescope frecency<cr>")
(map! [n] :<leader>G "<cmd>Telescope live_grep<cr>")
(map! [n] :<leader>H "<cmd>Telescope help_tags<cr>")
(map! [n] :<leader>N 'telescope.extensions.notify.notify)
