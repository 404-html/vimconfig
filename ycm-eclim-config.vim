let g:ycm_filetype_specific_completion_to_disable = {
      \ 'java' : 1,
      \ 'php' : 1
      \}

" Default: allow all
"let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_filetype_whitelist = {
      \ 'python' : 1,
      \ 'cpp' : 1,
      \ 'go' : 1,
      \ 'javascript' : 1,
      \ 'perl' : 1,
      \ 'scala' : 1,
      \ 'groovy' : 1,
      \ 'ruby' : 1
      \}

let g:ycm_filetype_blacklist = { '*': 1 }
"let g:ycm_filetype_blacklist = {
"      \ 'java' : 1,
"      \ 'php' : 1,
"      \ 'tagbar' : 1,
"      \ 'qf' : 1,
"      \ 'notes' : 1,
"      \ 'markdown' : 1,
"      \ 'unite' : 1,
"      \ 'text' : 1,
"      \ 'vimwiki' : 1,
"      \ 'pandoc' : 1,
"      \ 'infolog' : 1,
"      \ 'mail' : 1
"      \}

" let g:ycm_show_diagnostics_ui = 0

" YCM configs
" {{{
let g:jedi#goto_definitions_command = "Zi"
let g:ycm_global_ycm_extra_conf = ''
let g:ycm_confirm_extra_conf = 0

" this is in seconds
" https://docs.python.org/3.1/library/urllib.request.html
let g:tern_request_timeout = 10

" need this for compatibility with gitgutter
let g:ycm_enable_diagnostic_signs = 0

set cscopequickfix=s+,c+,d+,i+,t+,e+,g+

" }}}

"This is so YCM will fall back to eclim
let b:ycm_omnicomplete = 1
"However, this is also necessary:
"setlocal omnifunc=eclim#c#complete#CodeComplete
"setlocal omnifunc=eclim#python#complete#CodeComplete
let g:EclimCCallHierarchyDefaultAction = 'edit'

let g:ycm_allow_changing_updatetime = 0
" this is also used by autosave
"set updatetime=500
"set updatetime=1000
set updatetime=1500
"set updatetime=10000

let g:ycm_add_preview_to_completeopt = 0

let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->', '::'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'js' : ['.'],
  \   'erlang' : [':'],
  \ }
