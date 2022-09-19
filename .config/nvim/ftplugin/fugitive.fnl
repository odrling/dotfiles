(import-macros {: map! : augroup!} :macros)

(map! [n :buffer] :q "<CMD>q<CR>")

(local bufnr (vim.fn.bufnr))
(augroup! :fugitive_aucmd
          [[BufLeave] * #(vim.schedule #(pcall vim.api.nvim_buf_delete bufnr {})) bufnr])
