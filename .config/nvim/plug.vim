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
Plug 'tpope/vim-commentary'
Plug 'townk/vim-autoclose'
Plug 'machakann/vim-swap'

" format
Plug 'editorconfig/editorconfig-vim'

" files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
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
Plug 'docunext/closetag.vim', { 'for': ['html', 'xml'] }
Plug 'lervag/vimtex'

" completion
Plug 'neoclide/coc.nvim', {'do': './install.sh'}

call plug#end()
