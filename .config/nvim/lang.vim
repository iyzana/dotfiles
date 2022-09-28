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

" csv
let g:csv_no_conceal = 1

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
  \ '.component.scss': '.component.css',
  \ '.component.css': '.component.ts',
\ }]

autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" completion
inoremap <silent><expr> <c-space> coc#refresh()

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ CheckBackSpace() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
let g:coc_snippet_next = '<tab>'

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

