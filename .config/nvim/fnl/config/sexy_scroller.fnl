(import-macros {: g! : augroup!} :macros)

(when (vim.fn.exists "g:neovide")
      (g! SexyScroller_AutocmdsEnable 0))

(g! SexyScroller_MaxTime 200)

(augroup! :sexy_scroller_auto_toggle
          [[CmdlineLeave] * #(let [before vim.g.SexyScroller_MinLines]
                               (g! SexyScroller_MinLines 999999)
                               (vim.defer_fn #(g! SexyScroller_MinLines before) 200))])
