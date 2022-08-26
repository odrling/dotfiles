(import-macros {: setup} :macros)

(setup :dressing {:input {:override (fn [conf]
                                      (set conf.col -1)
                                      (set conf.row 0)
                                      :return conf)}})
