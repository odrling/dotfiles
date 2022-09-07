(import-macros {: setup : hl! : reqcall : prequire : exec} :macros)

;; set default background (before actual colorscheme is loaded)
(hl! Normal {:bg "#000000"})

(prequire stages_util :notify.stages.util
  (local stages [(fn [state]
                   (local next_row (stages_util.available_slot state.open_windows state.message.height stages_util.DIRECTION.TOP_DOWN))
                   :return {:height 1
                            :width state.message.width
                            :relative :editor
                            :anchor :NE
                            :border :rounded
                            :style :minimal
                            :col (vim.opt.columns:get)
                            :row next_row
                            :opacity 0})
                 (fn [state]
                   (vim.api.nvim_buf_call state.buffer #(exec [[:set (.. "textwidth=" state.message.width)]
                                                               [:%normal :gq]]))
                   (local next_height (+ (vim.api.nvim_buf_line_count state.buffer) 1))
                   :return {:col [(vim.opt.columns:get)]
                            :height {1 next_height :frequency 10}})
                 (fn []
                   :return {:time true
                            :opacity [100]
                            :col [(vim.opt.columns:get)]})
                 (fn []
                   :return {:opacity {1 0 :frequency 2}
                            :col [(vim.opt.columns:get)]})])

  (prequire notify :notify
    (notify.setup {:max_width 80
                   :stages stages
                   :on_open (fn [win]
                              (vim.api.nvim_win_set_option win :wrap true)
                              (vim.api.nvim_win_set_option win :linebreak true))})
    (set vim.notify notify)))
