(import-macros {: map!} :macros)

(map! [n] :<leader>ps #(set vim.b.parinfer_mode "smart"))
(map! [n] :<leader>pp #(set vim.b.parinfer_mode "paren"))
(map! [n] :<leader>pi #(set vim.b.parinfer_mode "indent"))
