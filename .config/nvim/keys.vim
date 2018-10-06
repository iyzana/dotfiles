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

" custom mappings
let mapleader=","
nnoremap <leader>p :PrettierAsync<CR>
nnoremap <leader>n :noh<CR>
nnoremap <leader>c :20sp +terminal<CR>aalias vim='echo no'<CR>clear<CR>
nnoremap <silent> <leader>k <Plug>(ale_previous_wrap)
nnoremap <silent> <leader>j <Plug>(ale_next_wrap)
nnoremap <C-p> :GFiles<CR>
nnoremap <C-6> <C-^>

" nerdtree
map <leader>tt :NERDTreeToggle<CR>
map <leader>tf :NERDTreeFind<CR>