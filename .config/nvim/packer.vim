augroup packer_user_config
  autocmd!
  autocmd BufWritePost packer.vim source <afile> | PackerCompile
augroup end

lua << EOF

require('packer').startup { 
  function()
    use 'lewis6991/impatient.nvim'
    use {'nathom/filetype.nvim',
         setup = [[vim.cmd('runtime! autoload/dist/ft.vim')]]}

    -- git
    use { 'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('config.neogit')
        end
    }
    use { 'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('gitsigns').setup({ current_line_blame = true }) 
        end
    }
    use { 'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('config.diffview')
        end
    }

    -- lsp
    use {'neovim/nvim-lspconfig',
        requires = {
                'ray-x/lsp_signature.nvim',
                'L3MON4D3/LuaSnip',
                'nvim-lua/lsp-status.nvim',
                'jose-elias-alvarez/null-ls.nvim',
                'williamboman/nvim-lsp-installer',
                'hrsh7th/nvim-cmp',
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-nvim-lsp',
                'tami5/lspsaga.nvim',
                'hrsh7th/cmp-path'
        },
        config = function()
            require('config.lsp')
        end
    }
    use 'ray-x/lsp_signature.nvim'
    use 'L3MON4D3/LuaSnip' 
    use 'nvim-lua/lsp-status.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/nvim-cmp'
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'tami5/lspsaga.nvim', requires = 'neovim/nvim-lspconfig' }
    use 'hrsh7th/cmp-path'

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
                'nvim-treesitter/playground',
                'RRethy/nvim-treesitter-endwise',
                'windwp/nvim-ts-autotag',
                'JoosepAlviste/nvim-ts-context-commentstring',
                'yioneko/nvim-yati'
        },
        config = function()
            require('config.treesitter')
        end
    }

    -- Interface
    use {
      "mcchrish/zenbones.nvim",
      requires = "rktjmp/lush.nvim",
    }
    use {'projekt0n/github-nvim-theme',
        config = function()
            vim.cmd [[ colorscheme github_light ]]
        end
    }
    use {'karb94/neoscroll.nvim',
        config = function()
            require('neoscroll').setup()
        end
    }
    use {'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('config.indent_blankline')
        end
    }
    use { 'nvim-lualine/lualine.nvim',
        config = function()
            require('config.lualine')
        end
    }
    use 'pappasam/papercolor-theme-slim'
    use 'folke/tokyonight.nvim'
    use 'NLKNguyen/papercolor-theme'
    use { 
        "projekt0n/circles.nvim", 
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require('config.circles')
        end
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'natecraddock/telescope-zf-native.nvim',
        'nvim-telescope/telescope-ui-select.nvim'
      },
      config = function()
          require('config.telescope')
      end
    }
    use "natecraddock/telescope-zf-native.nvim"
    use {'nvim-telescope/telescope-ui-select.nvim'}
    use {'akinsho/bufferline.nvim',
        config = function()
            require('config.bufferline')
        end
    }
    use {'moll/vim-bbye'}
    use { 'luukvbaal/nnn.nvim',
        config = function()
            require('config.nnn')
        end
    }
    use 'ggandor/lightspeed.nvim'

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
    use {'ZhiyuanLck/smart-pairs', event = 'InsertEnter', config = function() require('pairs'):setup() end}
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'kenn7/vim-arsync'
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

require('packer_compiled')
EOF
