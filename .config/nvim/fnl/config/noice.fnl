(import-macros {: setup} :macros)

(if (not vim.g.started_by_firenvim)
  (setup :noice))
