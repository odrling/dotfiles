(import-macros {: setup} :macros)

(local noice_config (require :noice.config))
(noice_config.setup)
;; (noice_config.options.routes [{:view :cmdline
;;                                :filter {:event :msg_show
;;                                          :kind [:echo :echomsg ""]
;;                                          :blocking true
;;                                          :max_height 1}}
;;                               {:view :cmdline
;;                                :filter {:any [{:event :cmdline}
;;                                               {:event :msg_show :kind :confirm}
;;                                               {:event :msg_show :kind :confirm_sub}
;;                                               {:event :msg_show
;;                                                :kind [:echo :echomsg ""]
;;                                                :before_input true}]}
;;                                :opts {:filter_options [{:filter {:event :cmdline}}
;;                                                        :opts {:buf_options {:filetype :vim}}]}}
;;                               {:view :split
;;                                :filter {:any [{:event :msg_history_show}]}}
;;                               {:filter {:any [{:event [:msg_showmode :msg_showcmd :msg_ruler]}
;;                                               {:event :msg_show :kind :search_count}]}}
;;                               {:view :notify
;;                                :filter {:event :noice
;;                                         :kind [:stats]}
;;                                :opts {:buf_options {:filetype :lua}
;;                                       :replace true}}
;;                               {:view :notify
;;                                :filter {:error true}
;;                                :opts {:level vim.log.levels.ERROR
;;                                       :replace false
;;                                       :title "Error"}}
;;                               {:view :notify
;;                                :filter {:event :msg_show
;;                                         :kind :wmsg}
;;                                :opts {:level vim.log.levels.WARN
;;                                       :replace false
;;                                       :title "Warning"}}])

(setup :noice.hacks)
(setup :noice.commands)
(setup :noice.router)
(setup :noice.ui)
