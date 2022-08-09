(local telescope (require :telescope))
(local telescope_themes (require :telescope.themes))

(telescope.setup {:pickers {:find_files {:find_command ["fd" "--type" "f" "--strip-cwd-prefix" "--hidden"]}}
                  :extensions {:ui-select [(telescope_themes.get_dropdown {})]}})

(telescope.load_extension :zf-native)
(telescope.load_extension :ui-select)
