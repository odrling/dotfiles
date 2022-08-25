(import-macros {: reqcall : map!} :macros)

(map! [nt] "<leader>t" #(reqcall :FTerm :toggle))
