" install vim-plug, if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-swap'
Plug 'wellle/targets.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'chiedo/vim-case-convert'
Plug 'gbprod/substitute.nvim'

" files
Plug 'junegunn/fzf', { 'dir': '~/.local/share/fzf', 'do': './install --all --xdg --no-bash --no-fish --no-update-rc' }
Plug 'junegunn/fzf.vim'
Plug 'ton/vim-alternate'

" layout
Plug 'scrooloose/nerdtree'
Plug 'woelke/vim-nerdtree_plugin_open'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'

" theme
Plug 'ayu-theme/ayu-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rakr/vim-one'
Plug 'doums/darcula'
Plug 'lifepillar/vim-gruvbox8'
Plug 'mechatroner/rainbow_csv'

" languages
Plug 'lervag/vimtex'

" completion
Plug 'neovim/nvim-lspconfig'

" Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'

" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'

" Plug 'williamboman/mason.nvim'
" Plug 'williamboman/mason-lspconfig.nvim'

" Plug 'nvim-lua/lsp-status.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" integrations
Plug 'samjwill/nvim-unception'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()

" sync plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" sync coc extensions
let g:coc_global_extensions = [
      \   'coc-angular',
      \   'coc-css',
      \   'coc-docker',
      \   'coc-emmet',
      \   'coc-eslint',
      \   'coc-html',
      \   'coc-json',
      \   'coc-markdownlint',
      \   'coc-prettier',
      \   'coc-python',
      \   'coc-rust-analyzer',
      \   'coc-sh',
      \   'coc-snippets',
      \   'coc-svg',
      \   'coc-toml',
      \   'coc-tslint-plugin',
      \   'coc-tsserver',
      \   'coc-vimtex',
      \ ]
