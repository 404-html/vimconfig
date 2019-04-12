""DO NOT use folding. It makes autocompletion extremely slow
"" use folding if we can
"if has ('folding')
"  set foldenable
"  "set foldmethod=marker
"  set foldmethod=syntax
"  set foldmarker={{{,}}}
"  "set foldcolumn=0
"  " need this set to something > 0 for the mouse to work
"  "set foldcolumn=2
"  set foldcolumn=0
"  set foldminlines=10
"  " start with 10 folds opened (ideally all)
"  set foldlevel=10
"endif

" setting foldmethod to manual speeds up vim auto-completion drastically
set foldmethod=manual

let b:ycm_omnicomplete = 1
setlocal omnifunc=eclim#c#complete#CodeComplete

imap -- ->
imap '' ->
