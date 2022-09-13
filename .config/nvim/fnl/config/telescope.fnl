(import-macros {: map!} :macros)

(local telescope (require :telescope))

(telescope.setup {:pickers {:find_files {:find_command ["fd" "--type" "f" "--strip-cwd-prefix" "--hidden"]}}})

(telescope.load_extension :zf-native)
(telescope.load_extension :notify)

(map! [n] :<leader><leader> "<cmd>Telescope find_files<cr>")
(map! [n] :<leader>G "<cmd>Telescope live_grep<cr>")
(map! [n] :<leader>H "<cmd>Telescope help_tags<cr>")
(map! [n] :<leader>N 'telescope.extensions.notify.notify)
