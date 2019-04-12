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
    let result=""
    if exists("YcmDebugInfo")
        let result = s:Exec(":YcmDebugInfo")
    endif
    return result =~ "Server running"
endfunction

function! s:HasYCMConfig()
    let result=""
    if exists("YcmDebugInfo")
        let result = s:Exec(":YcmDebugInfo")
    endif
    return result =~ "-- Flags for"
endfunction

function! s:HasEclim()
    return s:Exec(":ProjectInfo") =~ "Open.*true"
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
    YcmCompleter GoToDefinition
    "YcmCompleter GoToDeclaration
    redir END
    return @a
endfunction

function! s:TryCS()
    if s:HasCscope()
        exe ":silent! cs find g ".expand("<cword>")
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
    silent! QuickFixClear
    if empty(expand("<cword>"))
        echom "Nothing under cursor."
        return
    endif

    if &ft=~"python"
        if s:HasEclim()
            call s:TryEclimPython()
        elseif s:HasYCM()
            call s:TryYCMThenCSThenTags()
        endif
    elseif &ft=~"go"
        call s:TryGoGoDef()
    elseif &ft=~"cpp"
        if s:HasEclim()
            call s:TryEclimCPP()
        elseif s:HasYCM()
            call s:TryYCMThenCSThenTags()
        endif
    elseif &ft=~"html"
        "call s:CtrlPSearchJS()
        call s:VimGrep()
    elseif &ft=~"javascript"
        try
            call s:TryTern()
        catch
            call s:CtrlPSearchJS()
        endtry
    else
        if s:HasYCMConfig()
            call s:TryYCMThenCSThenTags()
        else
            call s:TryCSThenTags()
        endif
    endif
endfunction

"nnoremap <silent> <CR> :silent call <SID>GoToDefinition()<CR>
nnoremap <CR> :call <SID>GoToDefinition()<CR>
nnoremap <2-LeftMouse> :call <SID>GoToDefinition()<CR>

" do not apply above mapping to quickfix windows
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
