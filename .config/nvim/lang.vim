let g:LanguageClient_serverCommands = {
\   'rust': ['rls'],
\   'kotlin': ['kls'],
\   'reason': ['reason-language-server'],
\   'typescript': ['typescript-language-server', '--stdio'],
\}
let g:LanguageClient_diagnosticsEnable = 0

let g:ale_fixers = {
\   'rust': ['rustfmt'],
\   'typescript': ['prettier', 'tslint'],
\}
let g:ale_linter_aliases = {
\   'jsx': ['javascript'],
\}
let g:ale_linters = {
\   'rust': ['rls'],
\}
let g:ale_rust_rls_toolchain = 'stable'

autocmd FileType rust,kotlin,reason,typescript
  \ map <buffer> <F5> :call LanguageClient_contextMenu()<CR> |
  \ map <buffer> K :call LanguageClient#textDocument_hover()<CR> |
  \ map <buffer> gd :call LanguageClient#textDocument_definition()<CR> |
  \ map <buffer> <F2> :call LanguageClient#textDocument_rename()<CR> |
  \ map <buffer> <F7> :call LanguageClient#textDocument_references()<CR> |
  \ map <buffer> <leader>f :call LanguageClient#textDocument_formatting()<CR>

" autocmd FileType typescript
"   \ map <buffer> K :echo tsuquyomi#hint()<CR> |
"   \ map <buffer> gd :TsuDefinition<CR> |
"   \ map <buffer> <F2> :TsuRenameSymbol<CR> |
"   \ map <buffer> <leader>f :PrettierAsync<CR> |
"   \ map <buffer> <leader><CR> :TsuQuickFix<CR> |
"   \ map <buffer> <leader>i :TsuImport<CR>

let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}
