" prose
set spelllang=en,de_20,hun-de-DE-frami
autocmd Filetype markdown,tex setlocal spell
autocmd Filetype markdown,tex setlocal colorcolumn=100
autocmd Filetype markdown,tex setlocal textwidth=100
autocmd Filetype markdown,yaml,javascript,typescript setlocal tabstop=2
autocmd Filetype markdown,yaml,javascript,typescript setlocal shiftwidth=2

" tex
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {
    \ 'build_dir': 'build',
    \ 'continuous': 1,
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \   '-shell-escape',
    \ ],
  \ }

" \   '-output-directory=build',

" nav
let g:AlternatePath = []
let g:AlternateExtensionMappings = [{
  \ '.js': '.ts',
  \ '.ts': '.tsx',
  \ '.tsx': '.html',
  \ '.html': '.css',
  \ '.css': '.scss',
  \ '.scss': '.js',
\ }, {
  \ '.component.ts': '.component.html',
  \ '.component.html': '.component.scss',
  \ '.component.scss': '.component.ts',
\ }]

autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" completion
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

