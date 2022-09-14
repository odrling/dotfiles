(import-macros {: exec : map! : defhydra : reqcall : augroup!} :macros)

(local conflict_hint "
 _J_: Next conflict    _o_: Choose ours      _B_: Choose base 
 _K_: Prev conflict    _t_: Choose theirs    _N_: Choose none
 _l_: List conflicts   _b_: Choose both      _q_: Exit

")

(defhydra conflicts_hydra
    {:name "Git conflicts"
     :hint conflict_hint
     :mode ["n" "x"]
     :config {:color :pink
              :invoke_on_body true
              :hint {:border "rounded"}}}

    [[] "Next conflict"  :J #(reqcall :git-conflict :find_next "ours")]
    [[] "Prev conflict"  :K #(reqcall :git-conflict :find_prev "ours")]
    [[] "List conflicts" :l "<cmd>GitConflictListQf<cr>"]
    [[] false            :R #(reqcall :git-conflict :find_prev "ours")]

    [[] "Choose ours"    :o #(reqcall :git-conflict :choose "ours")]
    [[] "Choose theirs"  :t #(reqcall :git-conflict :choose "theirs")]
    [[] "Choose both"    :b #(reqcall :git-conflict :choose "both")]
    [[] "Choose base"    :B #(reqcall :git-conflict :choose "base")]
    [[] "Choose none"    :N #(reqcall :git-conflict :choose "none")]

    [[:exit :nowait] "Exit" :q]
    [[:exit :nowait] false :ESC])


(augroup! :conflicts_hydra
          [[User] :GitConflictDetected #(map! [n :buffer] "<leader>C" #(conflicts_hydra:activate))])
;; (map! [n] "<leader>C" #(conflicts_hydra:activate))

; Git Hydra
(local git_hint "
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full 
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
")

(defhydra git_hydra
    {:name "Git"
     :config {
              :color :pink
              :invoke_on_body true
              :hint false
              :on_enter (fn []
                            (vim.notify "Git hydra activated")
                            (reqcall :gitsigns :toggle_linehl true)
                            (reqcall :gitsigns :toggle_word_diff true)
                            (set vim.bo.modifiable false)
                            (pcall #(exec [[:mkview]
                                           [:silent! :%foldopen!]])))

              :on_exit #(pcall (fn []
                                   (pcall #(exec [[:loadview]
                                                  [:normal :zv]]))
                                   (vim.notify "Git hydra deactivated")
                                   (reqcall :gitsigns :toggle_linehl false)
                                   (reqcall :gitsigns :toggle_word_diff false)
                                   (reqcall :gitsigns :toggle_deleted false)))}
     :mode ["n" "x"]}

    [[:expr] "next hunk"
     :J #(if vim.wo.diff "]c"
                  (do (vim.schedule #(reqcall :gitsigns :next_hunk))
                      :return "<Ignore>"))]
    [[:expr] "prev hunk"
     :K #(if vim.wo.diff "[c"
              (do (vim.schedule #(reqcall :gitsigns :prev_hunk))
                  :return "<Ignore>"))]

    [[:silent]       "stage hunk"      :s       "<CMD>Gitsigns stage_hunk<CR>"]
    [[]              "undo last stage" :u       #(reqcall :gitsigns :undo_stage_hunk)]
    [[]              "stage buffer"    :S       #(reqcall :gitsigns :stage_buffer)]
    [[]              "preview hunk"    :p       #(reqcall :gitsigns :preview_hunk)]
    [[:nowait]       "toggle deleted"  :d       #(reqcall :gitsigns :toggle_deleted)]
    [[]              "blame"           :b       #(reqcall :gitsigns :blame_line)]
    [[]              "blame show full" :B       #(reqcall :gitsigns :blame_line {:full true})]
    [[]              "show base file"  :/       #(reqcall :gitsigns :show)]
    [[:exit :nowait] "Neogit"          :<Enter> #(reqcall :neogit :open)]
    [[:exit :nowait] "exit"            :q       nil]
    [[:exit :nowait] false             :<ESC>   nil])

(map! [n] "<leader>g" #(git_hydra:activate))
