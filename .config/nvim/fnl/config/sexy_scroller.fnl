(import-macros {: g! : augroup!} :macros)

(g! SexyScroller_MaxTime 200)

(augroup! :sexy_scroller_auto_toggle
          [[CmdlineLeave] * (fn []
                             (g! SexyScroller_MinLines 999999)
                             (vim.defer_fn #(g! SexyScroller_MinLines 3) 200))])
