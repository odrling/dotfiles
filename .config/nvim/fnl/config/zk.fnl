(import-macros {: augroup! : command!} :hibiscus.vim)
(import-macros {: map! : setup} :macros)

(local zk_util (require :zk.util))

(fn on_attach [_ bufnr] (when (~= (zk_util.notebook_root (vim.fn.getcwd)) nil)
                         (map! [n (:buffer bufnr)] :<leader><leader> "<cmd>ZkNotes<cr>")
                         (map! [v (:buffer bufnr)] :<leader>znt "<cmd>ZkNewFromTitleSelection {dir = vim.fn.expand('%:p:h')}<cr>")
                         (map! [v (:buffer bufnr)] :<leader>znc "<cmd>ZkNewFromContentSelection {dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ')}<cr>")
                         (map! [n (:buffer bufnr)] :K 'vim.lsp.buf.hover)
                         (map! [v (:buffer bufnr)] :<leader>za 'vim.lsp.buf.code_action)
                         (map! [v (:buffer bufnr)] :<leader>ca 'vim.lsp.buf.code_action)
                         (map! [n (:buffer bufnr)] :<leader>zb "<cmd>ZkBacklinks<cr>")
                         (map! [n (:buffer bufnr)] :<leader>zl "<cmd>ZkLinks<cr>")))

(setup :zk {:picker :telescope
            :lsp {:config {:on_attach on_attach}}})

(map! [n] :<leader>zn "<cmd>ZkNew<cr>")
(map! [n] :<leader>zo "<cmd>ZkNotes<cr>")
(map! [n] :<leader>zt "<cmd>ZkTags<cr>")
