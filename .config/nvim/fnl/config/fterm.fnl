(import-macros {: reqcall : map!} :macros)

(local M {})
(local fterm (require :FTerm))
(map! [nt] "<leader>t" #(fterm.toggle))

(local cmd ["lazygit"
            (if vim.env.GIT_DIR (.. "--git-dir=" vim.env.GIT_DIR))
            (if vim.env.GIT_WORK_TREE (.. "--work-tree=" vim.env.GIT_WORK_TREE))])

(set M.gitterm (fterm:new {:cmd cmd}))

:return M
