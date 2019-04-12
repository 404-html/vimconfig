setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
"setlocal nosmartindent
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class 
setlocal nofoldenable foldcolumn=0

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

let g:EclimPythonSearchSingleResult = 'edit'


"After upgrading YCM, ToggleEclimComplete is no longer required. <C-x><C-o> uses eclim if omnifunc is set
let b:ycm_omnicomplete = 1
setlocal omnifunc=eclim#python#complete#CodeComplete
"setlocal omnifunc=eclim#c#complete#CodeComplete
"function! ToggleEclimComplete()
"    if &omnifunc =~ 'eclim'
"        let &omnifunc=b:tmpomni
"        let &completefunc=b:tmpcomp
"        let b:tmpomni=''
"        let b:tmpcomp=''
"        echom "Eclim completion disabled"
"    else
"        let b:tmpomni=&omnifunc
"        let b:tmpcomp=&completefunc
"        setlocal omnifunc=eclim#python#complete#CodeComplete
"        "setlocal completefunc=eclim#python#complete#CodeComplete
"        setlocal completefunc=
"        echom "Eclim completion enabled"
"    endif
"endfunction
"
"nnoremap <buffer> <C-x><C-e> :call ToggleEclimComplete()<CR>
"inoremap <buffer> <C-x><C-e> :call ToggleEclimComplete()<CR>a<C-x><C-o>
