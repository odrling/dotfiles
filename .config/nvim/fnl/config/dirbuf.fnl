(import-macros {: map! : reqcall} :macros)

(map! [n] :<leader>o #(reqcall :dirbuf :open (vim.fn.fnameescape (vim.fn.expand "%:h"))))
(map! [n] :<leader>O #(reqcall :dirbuf :open (vim.fn.fnameescape (vim.fn.getcwd))))
