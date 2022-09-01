(import-macros {: map! : reqcall} :macros)

(map! [n] :<leader>o #(reqcall :dirbuf :open ""))
(map! [n] :<leader>O #(reqcall :dirbuf :open (vim.fn.fnameescape (vim.fn.getcwd))))
