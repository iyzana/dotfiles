" disable arrow keys
noremap <left> <nop>
inoremap <left> <nop>
noremap <right> <nop>
inoremap <right> <nop>
noremap <up> <nop>
inoremap <up> <nop>
noremap <down> <nop>
inoremap <down> <nop>

" split navigation
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" terminal navigation
tnoremap <C-h> <C-\><C-n><C-w><C-h>
tnoremap <C-j> <C-\><C-n><C-w><C-j>
tnoremap <C-k> <C-\><C-n><C-w><C-k>
tnoremap <C-l> <C-\><C-n><C-w><C-l>
tnoremap <Esc> <C-\><C-n>
autocmd BufEnter term://* startinsert

" custom mappings
let mapleader=" "
nnoremap <silent> <leader>n :noh<CR>
nnoremap <silent> <leader>c :wa<CR>:80vs +terminal<CR>a
nnoremap <C-6> <C-^>
vnoremap > >gv
vnoremap < <gv
nnoremap Q @@

" fzf
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>p :Files<CR>
nnoremap <C-f> :Rg<CR>
autocmd FileType fzf tnoremap <buffer> <Esc> <C-c>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \           fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

" nerdtree
map <silent><leader>t :NERDTreeFind<CR>
map <silent><leader>o :NERDTreeToggle<CR>

