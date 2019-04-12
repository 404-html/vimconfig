funct! s:Exec(command)
    redir =>output
    silent exec a:command
    redir END
    return output
endfunct!

function! s:HasCscope()
    return s:Exec(":cs show") =~ "pid"
endfunction

function! s:HasYCM()
    return s:Exec(":YcmDebugInfo") =~ "Server running"
endfunction

function! s:HasYCMConfig()
    return s:Exec(":YcmDebugInfo") =~ "-- Flags for"
endfunction

function! s:HasEclim()
    try
        return s:Exec(":ProjectInfo") =~ "Open.*true"
    catch
        return 1
    endtry
endfunction

function! s:TryEclimPython()
    try
        PythonSearchContext
    catch
        echom "Eclipse can't find it. Try rebuilding index and check pydev include path"
    endtry
    " This always does a zt which is unacceptable
    "exe "PythonSearchContext" | normal! zt
endfunction

function! s:TryGoGoDef()
    try
        GoDef
    catch
        echom "go's GoDef doesn't work. Maybe need to :GoInstallBinaries or go get -u all?"
    endtry
endfunction

function! s:TryEclimCPP()
    "Had to edit this to make it throw an exception
    "$BULK/source/git/config/vim/vim/eclim/autoload/eclim/lang.vim
    " Not sure if these are better the other way around
    try
        exe ":CSearchContext -a edit"
    catch
        exe ":CSearch -a edit ".expand("<cword>")
    endtry
endfunction

function! s:TryYCM()
    redir @a
    " This doesn't work as well as it should.
    YcmCompleter GoTo
    " YcmCompleter GoToDefinition
    "YcmCompleter GoToDeclaration
    redir END
    return @a
endfunction

function! s:TryCS()
    if s:HasCscope()
        " Don't make this silent.
        " Because if I make it silent, there will be no exception and
        " ctags won't be tried
        exe ":cs find g ".expand("<cword>")
    else
        throw "No cscope"
    endif
endfunction

function! s:TryCTags()
    " try to search using ctags
    "normal! 
    try
        exe ":silent! tag ".expand("<cword>")
    catch
        echom "no ctags file?"
    endtry
endfunction

function! s:TryCSThenTags()
    try
        call s:TryCS()
    catch
        call s:TryCTags()
    endtry
endfunction

" This doesn't work as well as it should.
" Just don't use YCM
function! s:TryYCMThenCSThenTags()
    let result=s:TryYCM()
    if result=~"RuntimeError" || result=~"ValueError"
        call s:TryCSThenTags()
    endif
endfunction

function! s:CtrlPSearchJS()
    normal vit"zy;let @z="\\(var\\s+\\<z\\>\\\|\\<z\\>\\s*=\\s*function(\\\|function\\s*\\<z\\>\\)";CtrlPLinerz 
endfunction

function! s:TryTern()
    redir @a
    TernDef
    redir END
    if @a=~"no definition found" || @a=~"TernError"
        raise "no definition found"
    endif
endfunction

function! s:VimGrep()
    normal *\gi
endfunction

function! s:GoToDefinition()
    QuickFixClear
    if empty(expand("<cword>"))
        echom "Nothing under cursor."
        return
    endif

    if &ft=~"python"
        if s:HasEclim()
            silent! call s:TryEclimPython()
        elseif s:HasYCM()
            call s:TryYCMThenCSThenTags()
        endif
    elseif &ft=~"go"
        call s:TryGoGoDef()
    elseif &ft=~"cpp"
        if s:HasEclim() && 0
            call s:TryEclimCPP()
        else
            call s:TryCSThenTags()
        " YCM goto def doesn't work that well
        " It's still pretty buggy
        "elseif s:HasYCM()
        "    call s:TryYCMThenCSThenTags()
        endif
    elseif &ft=~"html"
        "call s:CtrlPSearchJS()
        call s:VimGrep()
    elseif &ft=~"javascript"
        try
            call s:TryTern()
        catch
            silent! call s:CtrlPSearchJS()
        endtry
    else
        if s:HasYCMConfig()
            silent! call s:TryYCMThenCSThenTags()
        else
            call s:TryCSThenTags()
        endif
    endif
endfunction

"nnoremap <silent> <CR> :silent call <SID>GoToDefinition()<CR>
nnoremap <CR> :call <SID>GoToDefinition()<CR>
"nnoremap <2-LeftMouse> :call <SID>GoToDefinition()<CR>
"nmap <2-LeftMouse> <CR>
nmap <RightMouse> <CR>
    " This way, it will call goto-def if it's mapped to <CR>, which is
    " better

" do not apply above mapping to quickfix windows
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
