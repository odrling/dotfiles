(import-macros {: setup : map!} :macros)

(setup :bufferline {:options {:show_buffer_close_icons false
                              :show_close_icon false
                              :show_buffer_icons false
                              :separator_style :thin
                              :diagnostics :nvim_lsp}})

(fn close_buffers_except_current []
  (let [current (vim.fn.bufnr)]
    (each [_ buf (ipairs (vim.api.nvim_list_bufs))]
      (when (~= buf current)
        (vim.api.nvim_buf_delete buf {})))))

(map! [n] :<leader>q "<cmd>bdelete<cr>")
(map! [n] :<leader>Q 'close_buffers_except_current)
(map! [n] :<leader>b "<cmd>BufferLinePick<cr>")
(map! [n] :<leader>P "<cmd>BufferLineTogglePin<cr>")
