(import-macros {: setup : hl! : reqcall : prequire : exec} :macros)

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
                   (vim.api.nvim_buf_call state.buffer (fn [] (set vim.bo.modifiable true)
                                                              (set vim.bo.textwidth state.message.width)
                                                              (exec [[:%normal "gqq"]])
                                                              (set vim.bo.modifiable false)))
                   (local next_height (vim.api.nvim_buf_line_count state.buffer))
                   :return {:col [(vim.opt.columns:get)]
                            :height {1 next_height :frequency 10}})
                 (fn []
                   :return {:opacity [100]
                            :col [(vim.opt.columns:get)]})
                 (fn []
                   :return {:time true
                            :col [(vim.opt.columns:get)]})
                 (fn []
                   :return {:opacity {1 0 :frequency 2}
                            :col [(vim.opt.columns:get)]})])

  (prequire notify :notify
    (notify.setup {:max_width 80
                   :stages stages})
    (set vim.notify notify)))
