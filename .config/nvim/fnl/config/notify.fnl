(import-macros {: setup : hl! : reqcall : exec} :macros)

(macro prequire [name module ...]
  `(let [(ok?# mod#) (pcall require ,module)]
     (when ok?#
       (local ,name mod#)
       (do ,...))))


(prequire stages_util :notify.stages.util
  (local stages [(fn [state]
                   (local next_row (stages_util.available_slot state.open_windows state.message.height stages_util.DIRECTION.TOP_DOWN))
                   {:height state.message.height
                    :width state.message.width
                    :relative :editor
                    :anchor :NE
                    :border :rounded
                    :style :minimal
                    :col (vim.opt.columns:get)
                    :row next_row
                    :opacity 100})
                 (fn [state]
                   (vim.api.nvim_buf_call state.buffer (fn [] (set vim.bo.modifiable true)
                                                              (set vim.bo.textwidth state.message.width)
                                                              (exec [[:%normal "gqq"]])
                                                              (set vim.bo.modifiable false)))
                   (local next_height (vim.api.nvim_buf_line_count state.buffer))
                   (local next_row (stages_util.available_slot state.open_windows next_height stages_util.DIRECTION.BOTTOM_UP))
                   {:col [(vim.opt.columns:get)]
                    :height {1 next_height :frequency 10}})
                 (fn [state]
                   {:opacity [100]
                    :col [(vim.opt.columns:get)]})
                 (fn [state]
                   {:time true
                    :col [(vim.opt.columns:get)]})
                 (fn [state]
                   {:opacity {1 0 :frequency 2}
                    :col [(vim.opt.columns:get)]})])

  (prequire notify :notify
    (notify.setup {:max_width 80
                   :stages stages
                   :fps 10
                   :timeout 1500
                   :level vim.log.levels.INFO})
    (fn notify_fn [msg level opts]
      (vim.schedule #(notify msg level opts)))
    (set vim.notify notify_fn)))
