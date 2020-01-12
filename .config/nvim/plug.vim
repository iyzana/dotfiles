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

" format
Plug 'editorconfig/editorconfig-vim'

" files
Plug 'junegunn/fzf', { 'dir': '~/.local/share/fzf', 'do': './install --all --xdg --no-bash --no-fish' }
Plug 'junegunn/fzf.vim'

" layout
Plug 'scrooloose/nerdtree'
Plug 'woelke/vim-nerdtree_plugin_open'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'

" theme
Plug 'ayu-theme/ayu-vim'

" languages
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'
Plug 'dense-analysis/ale', { 'for': 'tex', 'on': 'ALEEnable' }

" completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

call plug#end()
