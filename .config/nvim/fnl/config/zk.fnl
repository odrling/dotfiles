(import-macros {: map! : augroup! : command!} :hibiscus.vim)

(local zk (require :zk))
(local zk_util (require :zk.util))
(zk.setup {:picker :telescope})

(local on_attach (fn [] (when (~= (zk_util.notebook_root (vim.fn.getcwd)) nil)
                          (map! [n :buffer] :<leader><leader> "<cmd>ZkNotes<cr>")
                          (map! [v :buffer] :<leader>znt "<cmd>ZkNewFromTitleSelection {dir = vim.fn.expand('%:p:h')}<cr>")
                          (map! [v :buffer] :<leader>znc "<cmd>ZkNewFromContentSelection {dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ')}<cr>")
                          (map! [n :buffer] :K 'vim.lsp.buf.hover)
                          (map! [v :buffer] :<leader>za 'vim.lsp.buf.code_action)
                          (map! [v :buffer] :<leader>ca 'vim.lsp.buf.code_action)
                          (map! [n :buffer] :<leader>zb "<cmd>ZkBacklinks<cr>")
                          (map! [n :buffer] :<leader>zl "<cmd>ZkLinks<cr>"))))

(map! [n] :<leader>zn "<cmd>ZkNew<cr>")
(map! [n] :<leader>zo "<cmd>ZkNotes<cr>")
(map! [n] :<leader>zt "<cmd>ZkTags<cr>")

(augroup! :zk [[BufEnter] * 'on_attach])
