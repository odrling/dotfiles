(import-macros {: setup : reqcall : map!} :macros)

(setup :FTerm)

(map! [nt] "<leader>t" #(reqcall :FTerm :toggle))
