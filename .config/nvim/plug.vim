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

" format
Plug 'editorconfig/editorconfig-vim'

" files
Plug 'junegunn/fzf', { 'dir': '~/.local/share/fzf', 'do': './install --all --xdg --no-bash --no-fish' }
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

" languages
Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale', { 'for': ['tex', 'sh', 'zsh'], 'on': 'ALEEnable' }

" completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" integrations
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
