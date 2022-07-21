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
    use {'akinsho/git-conflict.nvim', config = function()
        require('git-conflict').setup()
    end}

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
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-cmdline',
                'ray-x/cmp-treesitter',
                'kdheepak/cmp-latex-symbols',
                'hrsh7th/cmp-emoji',
                'petertriho/cmp-git',
                'b0o/schemastore.nvim'
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
                'yioneko/nvim-yati',
                'nvim-treesitter/nvim-treesitter-textobjects'
        },
        config = function()
            require('config.treesitter')
        end
    }
    use {
        "narutoxy/dim.lua",
        requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
        config = function()
            require('dim').setup({})
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
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
        end
    }
    use({
      'mvllow/modes.nvim',
      config = function()
        require('modes').setup {
            colors = {
                copy = "#f5c359",
                delete = "#c75c6a",
                insert = "#78ccc5",
                visual = "#9745be",
            },
            opacity = 0.15,
        }
      end
    })
    use {'windwp/nvim-autopairs',
         config = function()
             require('nvim-autopairs').setup()
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
    use 'rbgrouleff/bclose.vim'
    use 'ggandor/lightspeed.nvim'

    -- Misc
    use "elihunter173/dirbuf.nvim"
    use {
        "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    }
    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {}
        end
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'tpope/vim-sleuth'
    use 'kenn7/vim-arsync'
  end,
  config = {
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua"
  }
}

EOF

try
    lua require('packer_compiled')
catch
endtry
