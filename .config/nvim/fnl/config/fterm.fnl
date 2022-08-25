(import-macros {: setup : cfgcall : map!} :macros)

(setup :FTerm)

(map! [nt] "<leader>t" #(cfgcall :FTerm :toggle))
