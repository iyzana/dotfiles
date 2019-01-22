" install vim-plug, if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tomtom/tcomment_vim'

" format
Plug 'editorconfig/editorconfig-vim'

" files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" layout
Plug 'scrooloose/nerdtree'
Plug 'woelke/vim-nerdtree_plugin_open'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'

" theme
Plug 'ayu-theme/ayu-vim'

" languages
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'docunext/closetag.vim', { 'for': ['html', 'xml'] }

" completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Quramy/tsuquyomi'

call plug#end()
