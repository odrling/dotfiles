(import-macros {: map! : setup} :macros)

(setup :hlslens)

(map! [n :silent] :n  "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>")
(map! [n :silent] :N  "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>")
(map! [n :silent] :*  "*<Cmd>lua require('hlslens').start()<CR>")
(map! [n :silent] :#  "#<Cmd>lua require('hlslens').start()<CR>")
(map! [n :silent] :g* "g*<Cmd>lua require('hlslens').start()<CR>")
(map! [n :silent] :g# "g#<Cmd>lua require('hlslens').start()<CR>")
