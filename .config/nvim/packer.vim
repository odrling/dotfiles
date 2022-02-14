augroup packer_user_config
  autocmd!
  autocmd BufWritePost packer.vim source <afile> | PackerCompile
augroup end

lua << EOF

return require('packer').startup { 
  function()
    use 'lewis6991/impatient.nvim'
    use {'nathom/filetype.nvim',
         setup = [[vim.cmd('runtime! autoload/dist/ft.vim')]]}

    -- git
    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'ray-x/lsp_signature.nvim'
    use 'L3MON4D3/LuaSnip' 
    use 'nvim-lua/lsp-status.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/nvim-cmp'
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'tami5/lspsaga.nvim', requires = 'neovim/nvim-lspconfig' }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground', requires = 'nvim-treesitter/nvim-treesitter' }
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- Interface
    use {
      "mcchrish/zenbones.nvim",
      requires = "rktjmp/lush.nvim",
    }
    use { 'nvim-lualine/lualine.nvim' }
    use 'folke/tokyonight.nvim'
    use 'NLKNguyen/papercolor-theme'
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {'nvim-telescope/telescope-ui-select.nvim'}
    use {'akinsho/bufferline.nvim'}
    use {'moll/vim-bbye'}

    -- Misc
    use {
        "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    }
    use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
    }
    use 'Raimondi/delimitMate'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use {
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup { 
          mapping = {"jj"},
          timeout = vim.o.timeoutlen,
          clear_empty_lines = false,
          keys = "<ESC>",
        }
      end,
    }
  end,
  config = {
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua"
  }
}

EOF
