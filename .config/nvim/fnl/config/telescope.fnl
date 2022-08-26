(import-macros {: map!} :macros)

(local telescope (require :telescope))
(local telescope_themes (require :telescope.themes))

(telescope.setup {:pickers {:find_files {:find_command ["fd" "--type" "f" "--strip-cwd-prefix" "--hidden"]}}
                  :extensions {:ui-select [(telescope_themes.get_dropdown {})]}})

(telescope.load_extension :zf-native)
(telescope.load_extension :ui-select)

(map! [n] :<leader>ff "<cmd>Telescope find_files<cr>")
(map! [n] :<leader><leader> "<cmd>Telescope find_files<cr>")
(map! [n] :<leader>g "<cmd>Telescope live_grep<cr>")
(map! [n] :<leader>fh "<cmd>Telescope help_tags<cr>")
