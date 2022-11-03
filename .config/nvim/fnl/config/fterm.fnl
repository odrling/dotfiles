(import-macros {: reqcall : map!} :macros)

(local M {})
(local fterm (require :FTerm))
(map! [nt] "<leader>t" #(fterm.toggle))

(local cmd ["gitui"
            (if vim.env.GIT_DIR "--directory")
            (if vim.env.GIT_DIR vim.env.GIT_DIR)
            (if vim.env.GIT_WORK_TREE "--workdir")
            (if vim.env.GIT_WORK_TREE vim.env.GIT_WORK_TREE)])

(set M.gitterm (fterm:new {:cmd cmd}))

:return M
