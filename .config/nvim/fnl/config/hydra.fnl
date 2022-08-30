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
              :on_enter #(gitsigns.toggle_linehl true)
              :on_exit (fn []
                         (gitsigns.toggle_linehl false)
                         (gitsigns.toggle_deleted false))}
     :mode ["n" "x"]}

    (:J #(if vim.wo.diff "]c"
                 (do (vim.schedule #(gitsigns.next_hunk))
                     :return "<Ignore>"))
         {:expr true
          :desc "next hunk"})
    (:K #(if vim.wo.diff "[c"
              (do (vim.schedule #(gitsigns.prev_hunk))
                  :return "<Ignore>"))
     {:expr true
      :desc "next hunk"})

    (:s "<CMD>Gitsigns stage_hunk<CR>" {:silent true :desc "stage hunk"})
    (:u gitsigns.undo_stage_hunk {:desc "undo last stage"})
    (:S gitsigns.stage_buffer {:desc "stage buffer"})
    (:p gitsigns.preview_hunk {:desc "preview hunk"})
    (:d gitsigns.toggle_deleted {:nowait true :desc "toggle deleted"})
    (:b gitsigns.blame_line {:desc "blame"})
    (:B #(gitsigns.blame_line {:full true}) {:desc "blame show full"})
    (:/ gitsigns.show {:exit true :desc "show base file"})
    (:<Enter> "<CMD>Neogit<CR>" {:exit true :desc "Neogit"})
    (:q nil {:exit true
             :nowait true
             :desc "exit"}))

(map! [n] "<leader>g" #(git_hydra:activate))
