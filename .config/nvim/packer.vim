augroup packer_user_config
  autocmd!
  autocmd BufWritePost packer.vim source <afile> | PackerCompile
augroup end

lua << EOF

return require('packer').startup(function()
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

  -- Interface
  use 'liuchengxu/space-vim-theme'
  use 'liuchengxu/eleline.vim'

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

end)

EOF
