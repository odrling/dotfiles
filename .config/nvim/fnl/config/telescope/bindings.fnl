(import-macros {: map!} :macros)

(map! [n] :<leader><leader> "<cmd>Telescope find_files<cr>")
(map! [n] :<leader>G "<cmd>Telescope live_grep<cr>")
(map! [n] :<leader>H "<cmd>Telescope help_tags<cr>")
