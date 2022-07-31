(require-macros :hibiscus.vim)
(augroup! :packer
          [[BufWritePost] packer.fnl "silent! FnlCompileBuffer"]
          [[BufWritePost] packer.fnl "PackerCompile"])
          

(require-macros :hibiscus.packer)

(packer-setup)

(packer
  (use! :udayvir-singh/tangerine.nvim)
  (use! :udayvir-singh/hibiscus.nvim)
  (use! :lewis6991/impatient.nvim)
  (use! :nathom/filetype.nvim)

  ; git
  (use! :TimUntersberger/neogit
        :requires :nvim-lua/plenary.nvim
        :module :config.neogit)

  (use! :akinsho/git-conflict.nvim
        :config (fn [] 
                 (. (require :git-conflict) :setup)))
   
  (use! :lewis6991/gitsigns.nvim
        :requires :nvim-lua/plenary.nvim
        :config (fn []
                  ((. (require :gitsigns) :setup) {:current_line_blame true})))
  (use! :sindrets/diffview.nvim
        :requires :nvim-lua/plenary.nvim
        :module :config.diffview)

  ; lsp
  (use! :neovim/nvim-lspconfig
        :requires [
                   :ray-x/lsp_signature.nvim
                   :L3MON4D3/LuaSnip
                   :nvim-lua/lsp-status.nvim
                   :jose-elias-alvarez/null-ls.nvim
                   :williamboman/mason.nvim
                   :williamboman/mason-lspconfig.nvim
                   :hrsh7th/nvim-cmp
                   :saadparwaiz1/cmp_luasnip
                   :hrsh7th/cmp-nvim-lsp
                   :tami5/lspsaga.nvim
                   :hrsh7th/cmp-path
                   :hrsh7th/cmp-buffer
                   :hrsh7th/cmp-cmdline
                   :ray-x/cmp-treesitter
                   :kdheepak/cmp-latex-symbols
                   :hrsh7th/cmp-emoji
                   :petertriho/cmp-git
                   :b0o/schemastore.nvim
                   :windwp/nvim-autopairs]
        
        :module :config.lsp)
  (use! :windwp/nvim-autopairs
        :config (fn []
                  ((. (require :nvim-autopairs) :setup) {})))
        

  ; Treesitter
  (use! :nvim-treesitter/nvim-treesitter
        :run ":TSUpdate"
        :requires [
                   "nvim-treesitter/playground"
                   "RRethy/nvim-treesitter-endwise"
                   "windwp/nvim-ts-autotag"
                   "JoosepAlviste/nvim-ts-context-commentstring"
                   "yioneko/nvim-yati"
                   "nvim-treesitter/nvim-treesitter-textobjects"]
         
        :module :config.treesitter)
        
  (use! :narutoxy/dim.lua
        :requires [
                   :nvim-treesitter/nvim-treesitter
                   :neovim/nvim-lspconfig]
        
        :config (fn []
                  ((. (require :dim) :setup) {})))
        

  (use! :gpanders/nvim-parinfer)

  ; Interface
  (use! :projekt0n/github-nvim-theme
        :config (fn []
                  (exec [[:colorscheme :github_light]])))
  (use! :folke/which-key.nvim
        :config (fn []
                  ((. (require :which-key) :setup) {})))
  (use! :mvllow/modes.nvim
        :config (fn []
                  ((. (require :modes) :setup) {:opacity 0.15})))
  (use! :lukas-reineke/indent-blankline.nvim
        :module :config.indent_blankline)
  (use! :nvim-lualine/lualine.nvim
        :module :config.lualine)
  (use! :projekt0n/circles.nvim
        :requires :kyazdani42/nvim-web-devicons
        :module :config.circles)
  (use! :nvim-telescope/telescope.nvim
        :requires [ :nvim-lua/plenary.nvim
                    :natecraddock/telescope-zf-native.nvim
                    :nvim-telescope/telescope-ui-select.nvim]
        :module :config.telescope)
  (use! :akinsho/bufferline.nvim
        :module :config.bufferline)
  (use! :rbgrouleff/bclose.vim)
  (use! :ggandor/leap.nvim
        :config (fn []
                  ((. (require :leap) :set_default_keymaps) {})))
  (use! :antoinemadec/FixCursorHold.nvim)
  (use! :elihunter173/dirbuf.nvim)
  (use! :luukvbaal/stabilize.nvim
        :config (fn []
                  ((. (require :stabilize) :setup) {})))
  (use! :ahmedkhalf/project.nvim
        :config (fn []
                  ((. (require :project_nvim) :setup) {})))
  (use! :numToStr/Comment.nvim
        :config (fn []
                  ((. (require :Comment) :setup) {})))
  (use! :tpope/vim-repeat)
  (use! :tpope/vim-surround)
  (use! :tpope/vim-sleuth)
  (use! :kenn7/vim-arsync))
