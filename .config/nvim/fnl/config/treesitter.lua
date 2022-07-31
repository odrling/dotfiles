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

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

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
  },
  yati = {
      enable = true
  }
}

