(import-macros {: exec : map! : defhydra} :macros)
(local Hydra (require :hydra))

; Git Hydra
(local gitsigns (require :gitsigns))

(local git_hint "
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
")

(defhydra git_hydra
    {:name "Git"
     :hint git_hint
     :config {
              :color :pink
              :invoke_on_body true
              :hint {:border "rounded"}
              :on_enter (fn []
                            (gitsigns.toggle_linehl true)
                            (gitsigns.toggle_word_diff true)
                            (set vim.bo.modifiable false))
              :on_exit (fn []
                         (gitsigns.toggle_linehl false)
                         (gitsigns.toggle_word_diff false)
                         (gitsigns.toggle_deleted false))}
     :mode ["n" "x"]}

    [[:expr] "next hunk"
     :J #(if vim.wo.diff "]c"
                  (do (vim.schedule #(gitsigns.next_hunk))
                      :return "<Ignore>"))]
    [[:expr] "prev hunk"
     :K #(if vim.wo.diff "[c"
              (do (vim.schedule #(gitsigns.prev_hunk))
                  :return "<Ignore>"))]

    [[:silent]       "stage hunk"      :s       "<CMD>Gitsigns stage_hunk<CR>"]
    [[]              "undo last stage" :u       gitsigns.undo_stage_hunk]
    [[]              "stage buffer"    :S       gitsigns.stage_buffer]
    [[]              "preview hunk"    :p       gitsigns.preview_hunk]
    [[:nowait]       "toggle deleted"  :d       gitsigns.toggle_deleted]
    [[]              "blame"           :b       gitsigns.blame_line]
    [[]              "blame show full" :B       #(gitsigns.blame_line {:full true})]
    [[:exit]         "show base file"  :/       gitsigns.show]
    [[:exit]         "Neogit"          :<Enter> "<CMD>Neogit<CR>"]
    [[:exit :nowait] "exit"            :q       nil])

(map! [n] "<leader>g" #(git_hydra:activate))
