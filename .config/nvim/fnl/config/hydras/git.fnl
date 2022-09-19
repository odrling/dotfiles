(import-macros {: exec : map! : defhydra : reqcall : augroup!} :macros)

; Git Hydra
(local git_hint "
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full 
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: status      ^ ^                 _q_: exit
")

(defhydra git_hydra
    {:name "Git"
     :hint git_hint
     :config {:color :pink
              :invoke_on_body true
              :hint {:type :cmdline}
              :on_enter (fn []
                            (reqcall :gitsigns :toggle_linehl true)
                            (reqcall :gitsigns :toggle_word_diff true)
                            (set vim.bo.modifiable false))

              :on_exit (fn []
                           (reqcall :gitsigns :toggle_linehl false)
                           (reqcall :gitsigns :toggle_word_diff false)
                           (reqcall :gitsigns :toggle_deleted false))
              :on_key #(print git_hint)}
     :mode ["n" "x"]}

    [[:expr] "next hunk"
     :J #(if vim.wo.diff "]c"
           (do (vim.schedule #(reqcall :gitsigns :next_hunk {:navigation_message false}))
             :return "<Ignore>"))]
    [[:expr] "prev hunk"
     :K #(if vim.wo.diff "[c"
           (do (vim.schedule #(reqcall :gitsigns :prev_hunk {:navigation_message false}))
             :return "<Ignore>"))]

    [[:silent]       "stage hunk"      :s       "<CMD>Gitsigns stage_hunk<CR>"]
    [[]              "undo last stage" :u       #(reqcall :gitsigns :undo_stage_hunk)]
    [[]              "stage buffer"    :S       #(reqcall :gitsigns :stage_buffer)]
    [[]              "preview hunk"    :p       #(reqcall :gitsigns :preview_hunk)]
    [[:nowait]       "toggle deleted"  :d       #(reqcall :gitsigns :toggle_deleted)]
    [[]              "blame"           :b       #(reqcall :gitsigns :blame_line)]
    [[]              "blame show full" :B       #(reqcall :gitsigns :blame_line {:full true})]
    [[]              "show base file"  :/       #(reqcall :gitsigns :show)]
    [[:exit]         "status"          :<Enter> #(vim.schedule #(vim.cmd.Git))]
    [[:exit :nowait] "exit"            :q       nil]
    [[:exit :nowait] false             :<ESC>   nil])

(map! [n] "<leader>g" #(git_hydra:activate))
