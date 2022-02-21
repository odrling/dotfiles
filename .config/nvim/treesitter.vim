try
  lua <<EOF
  require'nvim-treesitter.configs'.setup {
    -- Modules and its options go here
    highlight = { 
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = { enable = true },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
    playground = {
      enable = true,
      updatetime = 25
    },
    endwise = {
      enable = true
    },
    autotag = {
      enable = true
    }
    yati = {
        enable = true
    }
  }
EOF

  " set foldmethod=expr
  " set foldexpr=nvim_treesitter#foldexpr()
catch
  echo "treesitter is not set up properly"
endtry
