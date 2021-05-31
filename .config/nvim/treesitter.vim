try
  lua <<EOF
  require'nvim-treesitter.configs'.setup {
    -- Modules and its options go here
    highlight = { enable = false },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
    playground = {
      enable = true,
      updatetime = 25
    }
  }
EOF

  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
catch
  echo "treesitter is not set up properly"
endtry
