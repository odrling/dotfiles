(import-macros {: setup : map! : augroup!} :macros)

(setup :oil {:view_options {:is_hidden_file (fn [name bufnr] false)}})

(augroup! :oil_rename
          [[User] OilActionsPost (fn [event]
                                   (when (= event.data.actions.type :move)
                                     (Snacks.rename.on_rename_file event.data.actions.src_url event.data.actions.dest_url)))])

(map! [n] :<leader>o #(vim.cmd.Oil))
(map! [n] :<leader>O #(vim.cmd.Oil (vim.fn.fnameescape (vim.fn.getcwd))))
