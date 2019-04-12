""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE:
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE:
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained silent! below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fun! LoadCscope(arg)
    " if v:shell_error == 1 && filereadable(GetGitConfigDir() . "/cscope/cscope.out")
        " silent! exec "cs add ".GetGitConfigDir()."/cscope/cscope.out"
        " let cscope_path = GetGitConfigDir()."/cscope/cscope.out"
    " else
        " silent! exec "cd add ".a:arg
        " let cscope_path = a:arg
    " endif
    
    " if !empty(cscope_path) && filereadable(cscope_path)
        " let g:cscope_path=cscope_path
        " silent! exec "cs add ".cscope_path
    " endif
" endf

" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    
    " Test
    " if filereadable(GetGitConfigDir() . "/cscope/cscope.out") | echo "readable" | else | echo "not readable" | endif
    " if filereadable(GetGitDir() . "/cscope.out") | echo "readable" | else | echo "not readable" | endif

    call system('test -s cscope.out')
    if v:shell_error == 0
        let cscope_path="cscope.out"
    elseif v:shell_error == 1
        if filereadable(GetGitConfigDir() . "/cscope/cscope.out")
            let cscope_path=GetGitConfigDir()."/cscope/cscope.out"
        elseif filereadable(GetGitDir() . "/cscope.out")
            let cscope_path=GetGitDir()."/cscope.out"
        elseif filereadable("cscope.out")
            let cscope_path="cscope.out"
        elseif $CSCOPE_DB != ""
            " cs add $CSCOPE_DB
            let cscope_path=$CSCOPE_DB
        " else
            " let cscope_path="hi"
        endif
    endif

    if !empty(cscope_path) && filereadable(cscope_path)
        " let g:cscope_path
        silent! exec "cs add ".cscope_path
    endif

    " show msg when any other cscope db added
    set cscopeverbose


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " silent! below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.

"function! Test()
"    while 1
"        try
"            try
"                continue
"            catch /^Vim:Interrupt$/
"                echo "\nThis is the nested try/catch/endtry"
"                echo "Command interrupted"
"            endtry
"        catch /^Vim:Interrupt$/
"            echo "\nInput interrupted"
"            break
"        endtry
"    endwhile
"endfunction
"
":call Test()
"

    function! CCTreeSearch(direction)
        try
            cs reset
            CCTreeLoadDB
            let @/=expand("<cword>")
            set hls
            exe "CCTreeTrace".a:direction." ".expand("<cword>")
        catch
            echom "cctree error"
        endtry
    endfunction

    function! QuickFixClear()
        call setqflist([])
    endfunction
    command! QuickFixClear call QuickFixClear()

    function! CscopeSearch(type)
        " try
            silent! cs reset
            let pattern = expand("<cword>")
            let @/=pattern
            " echom "cs find ".a:type." ".pattern
            set hls
            QuickFixClear
            exe "silent! cs f ".a:type." ".pattern
            normal! 
            exe "silent! below copen ".(winheight(0) / 2)
            set modifiable
            silent! %!mnm
            "normal! 
        " catch
            " echom "Could not find it in cscope"
        " endtry
    endfunction

    nnoremap ts :call CscopeSearch("s")<CR>
    nnoremap tg :silent call CscopeSearch("g")<CR>
    nnoremap tc :silent call CscopeSearch("c")<CR>
    nnoremap tt :silent call CscopeSearch("t")<CR>
    nnoremap te :silent call CscopeSearch("e")<CR>
    nnoremap tf :silent call CscopeSearch("f")<CR>
    nnoremap ti :silent call CscopeSearch("i")<CR>
    nnoremap td :silent call CscopeSearch("d")<CR>
    nnoremap th :silent! CCallHierarchy<CR>:only<CR>
    nnoremap t> :silent call CCTreeSearch("Forward")<CR>
    nnoremap t< :silent call CCTreeSearch("Reverse")<CR>


    nnoremap <C-w>ts :echom "use ts instead"<CR>
    nnoremap <C-w>tg :echom "use tg instead"<CR>
    nnoremap <C-w>tc :echom "use tc instead"<CR>
    nnoremap <C-w>tt :echom "use tt instead"<CR>
    nnoremap <C-w>te :echom "use te instead"<CR>
    nnoremap <C-w>tf :echom "use tf instead"<CR>
    nnoremap <C-w>ti :echom "use ti instead"<CR>
    nnoremap <C-w>td :echom "use td instead"<CR>

    "" open in new tab (my addition)
    "nnoremap <C-w>ts :silent cs reset<CR>:tab scs find s <C-R>=expand("<cword>")<CR><CR>
    "nnoremap <C-w>tg :silent cs reset<CR>:tab scs find g <C-R>=expand("<cword>")<CR><CR>
    "nnoremap <C-w>tc :silent cs reset<CR>:tab scs find c <C-R>=expand("<cword>")<CR><CR>
    "nnoremap <C-w>tt :silent cs reset<CR>:tab scs find t <C-R>=expand("<cword>")<CR><CR>
    "nnoremap <C-w>te :silent cs reset<CR>:tab scs find e <C-R>=expand("<cword>")<CR><CR>
    "nnoremap <C-w>tf :silent cs reset<CR>:tab scs find f <C-R>=expand("<cfile>")<CR><CR>
    "nnoremap <C-w>ti :silent cs reset<CR>:tab scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nnoremap <C-w>td :silent cs reset<CR>:tab scs find d <C-R>=expand("<cword>")<CR><CR>


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    nmap <C-@>s ts
    nmap <C-@>g tg
    nmap <C-@>c tc
    nmap <C-@>t tt
    nmap <C-@>e te
    nmap <C-@>f tf
    nmap <C-@>i ti
    nmap <C-@>d td


    " Hitting CTRL-space *twice* before the search type does a vertical
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s ts
    nmap <C-@><C-@>g tg
    nmap <C-@><C-@>c tc
    nmap <C-@><C-@>t tt
    nmap <C-@><C-@>e te
    nmap <C-@><C-@>f tf
    nmap <C-@><C-@>i ti
    nmap <C-@><C-@>d td


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line silent! below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif
