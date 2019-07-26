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
nnoremap <silent> <leader>c :80vs +terminal<CR>a
nmap <silent> <leader>f <Plug>(ale_fix)
nnoremap <C-6> <C-^>
vnoremap > >gv
vnoremap < <gv
nnoremap Q @@

" kakoune
nnoremap gh 0
nnoremap gl $
nnoremap gk gg
nnoremap gj G
nnoremap gi ^
nnoremap m %

" fzf
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>p :Files<CR>
nnoremap <C-f> :GLines<CR>

command! -bang -nargs=* GLines
    \ call fzf#vim#grep(
    \   'rg --fixed-strings --smart-case --column --line-number --no-heading --color=always --hidden --glob "!.git/*" '.shellescape(<q-args>),
    \   1, <bang>0)

" nerdtree
map <silent><leader>t :NERDTreeFind<CR>
map <silent><leader>o :NERDTreeToggle<CR>

" completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
