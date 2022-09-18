(import-macros {: g! : augroup!} :macros)

(when (vim.fn.exists "g:neovide")
      (g! SexyScroller_AutocmdsEnable 0))

(g! SexyScroller_MaxTime 200)
(local minlines 3)
(g! SexyScroller_MinLines minlines)

(augroup! :sexy_scroller_auto_toggle
          [[CmdlineLeave] [:/ :\?] (fn []
                                     (g! SexyScroller_MinLines (+ (vim.api.nvim_buf_line_count 0) 1))
                                     (vim.defer_fn #(g! SexyScroller_MinLines minlines) 200))])
