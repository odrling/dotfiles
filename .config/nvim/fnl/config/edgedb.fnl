(import-macros {: augroup!} :macros)

(augroup! :edgedb
          [[BufNewFile BufRead] "*.edgeql" #(set vim.bo.filetype :edgeql)]
          [[BufNewFile BufRead] "*.esdl"   #(set vim.bo.filetype :edgeql)])
