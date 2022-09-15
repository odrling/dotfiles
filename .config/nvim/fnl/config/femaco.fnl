(import-macros {: setup : reqcall : map!} :macros)

(setup :femaco)
(map! [n] :<leader>e #(reqcall :femaco.edit :edit_code_block))
