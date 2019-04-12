"get-notes-commands.sh | fzf --sort -q "'arduino '=cycl 'rtm '" options
" {{{

call pathogen#infect()
"execute pathogen#infect('bundle/{}', '~/var/smulliga/source/git/config/vim/vim/bundle/{}')

" let g:mygit = "/var/smulliga/source/git"

let g:mygit = $MYGIT
exe "source ".g:mygit."/config/vim/nvimrc"

let g:myhome = $HOME

set sessionoptions-=options

set nowarn

"set rtp+=/export/bulk/local-home/smulliga/dump/var/smulliga/notes/ws/go/workspace/src/github.com/mullikine/fzf

exe "set rtp+=".g:mygit."/junegunn/fzf"

set encoding=utf-8
set fileencodings=ucs-bom,utf-8

" fuck vi
set nocompatible

set guifont=Courier\ New\ 12
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif
colorscheme inkpot

" show hidden/invisible characters, like line endings and show tabs
"set listchars=nbsp:¬,eol:$,tab:>-,trail:~,extends:>,precedes:<
set listchars=nbsp:¬,tab:>-
"set listchars=eol:¶,tab:>-,extends:»,precedes:«,trail:•
set list " make this a togglable option. " this is enabled because bad whitespace highlighting with no background is invisible otherwise. remember to toggle off before doing tmux C-M-d
"setting list is not the solution
"enable with mininimal listchars and then do preprocessing when using
"tmux-jump.

" this breaks vim-snipets.
" disable from cursorline
set cursorline

" man page program
" the following doesn't work
"set keywordprg="/export/bulk/local-home/smulliga/projects/scripts/manQ
"set keywordprg="man -s"
"set keywordprg="tm -f nw \"man\""

" main options
"set shortmess+=c

"set number

set diffopt+=vertical
" This is bad as a default, but needs to be easily togglable
"set diffopt+=iwhite
set isk+=é
" this allows filename completion with spaces. however, it also means spaces before the path name mess it up
set isf+=32
set isf+=\*

" These are needed for shell variables
set isf+={
set isf+=}

set isf+=(
set isf+=)
set isf+=[
set isf+=]
set isf+=:
set isf+=;
set isf+=\\
set isf+=\?
set isf+=#
set isf+=%
" @ sign doesn't appar to work for cfile
" @re
" echom expand('<cfile>')
set isf+=@
" add ampersand to filename selection
" ASCII number
"set isf+=38
" add questionmark to filename selection for urls
set isf+=63
" add ampersand ( use ascii command line  to work these out )
set isf+=38
silent! set norelativenumber
" this stops commands like :grep outputting to the shell
"set relativenumber
set shellpipe=&>
set maxmempattern=2000
set switchbuf=usetab
" this means that F7 toggles paste in input mode as well as normal mode
set pastetoggle=<F7>
" doesn't work unless binary is set (which is an annoying predicament)
set nostartofline
set noeol
set hidden
set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set lazyredraw
set expandtab
set formatoptions-=t
set history=50
set nohlsearch
set ignorecase smartcase
set incsearch
set ls=2
set nobackup
set nomousehide
set nowrap
set vb t_vb=
set novisualbell
set scrolloff=5
set sidescrolloff=12
set shiftwidth=4
set shortmess+=r
set showmode
"this does NOT cause 'press enter or type command to continue'
set showcmd
set showtabline=0
set sm
" spellfile must end in ".{encoding}.add".
set spellfile=$HOME/notes/ws/vim/spellfile.utf-8.add
set smartcase
set smartindent
set copyindent
set preserveindent
set smarttab
set splitright
set tabstop=4
set tags=~/.tags
set notitle
" setting virtualedit to onemore fixes the ‘cw’ bug for words at end of
" file
"set virtualedit=onemore
set virtualedit=all
if &term == "xterm"
  set title
endif
set textwidth=72
set visualbell t_vb=
if version > 720
    set undoreload=0
endif

set matchpairs+=<:>
set matchpairs+=‘:’
set matchpairs+=“:”

" syntax highlighting is messed up by this
"let g:EasyMotion_do_shade = 0

set thesaurus+=~/.vim/mthes10/thesaurus.txt
set completeopt=longest,menuone

" vim command-line autocomplete, not regular autocomplete
set wildmenu
set wildmode=list:longest,full

call system("mkdir -p /dev/shm/var/tmp/shane/vim")

" where swap files go now
set noswapfile " Swap is disabled. Using git anyway.
"swap messages are super annoying
"set swapfile
" Vim is scaring me by deleting files.
set backupdir=/dev/shm/var/tmp/shane/vim
set directory=/dev/shm/var/tmp/shane/vim
set undodir=/dev/shm/var/tmp/shane/vim

" this little quote is not part of a string. Do not end in a quote
 
if !has('nvim')
    set viminfo+='1000,n/dev/shm/var/tmp/shane/vim/viminfo
endif

" vim uses x11 clipboard
"set clipboard=unnamed
set clipboard=unnamedplus
set go=

let b:minimisedname = ''
function! GetMinimisedName()
    if !exists("b:minimisedname")
        let b:minimisedname = ''
    endif
    return b:minimisedname
endfunction

au BufAdd * let b:minimisedname = system('lit -n "'.expand('%:p').'" | mnm')
au BufEnter * let b:minimisedname = system('lit -n "'.expand('%:p').'" | mnm')
au BufReadPre * let b:minimisedname = system('lit -n "'.expand('%:p').'" | mnm')
au BufWritePre * let b:minimisedname = system('lit -n "'.expand('%:p').'" | mnm')

source $VIMCONFIG/utils.vim

" display cursor hilight
" {{{
if has('statusline')
   " Status line detail:
   " %f     file path
   " %F     full file path
   " %y     file type between braces (if defined)
   " %([%R%M]%)   read-only, modified and modifiable flags between braces
   " %{'!'[&ff=='default_file_format']}
   "        shows a '!' if the file format is not the platform
   "        default
   " %{'$'[!&list]}  shows a '*' if in list mode
   " %{'~'[&pm=='']} shows a '~' if in patchmode
   " (%{synIDattr(synID(line('.'),col('.'),0),'name')})
   "        only for debug : display the current syntax item name
   " %=     right-align following items
   " #%n    buffer number
   " %l/%L,%c%V   line number, total number of lines, and column number
   function! SetStatusLineStyle()
      if &stl == '' || &stl =~ 'synID'
         " fast
         " what's up with this?
         "let &stl="%F %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}%{'~'[&pm=='']}%=#%n %l/%L,%c%V"

         " best
         "let &stl="%{system('echo -n \"'.expand('%:p').'\" | mnm')} %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%r%=%b\ 0x%B\ \ %l,%c%V\ %P  %=#%n %l/%L,%c%V"
         let &stl="%{GetMinimisedName()} %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%r%=%b\ 0x%B\ \ %l,%c%V\ %P  %=#%n %l/%L,%c%V"
         "let &stl="hello"

         "let &stl="%{system('echo -n \"'.expand('%:p').'\"')} %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%r%=%b\ 0x%B\ \ %l,%c%V\ %P  %=#%n %l/%L,%c%V"
      else
         " normal sl
         "let &stl="%F %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=#%n %l/%L,%c%V"

         " Show ascii value of current character
         "let &stl="%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P"

         " Show normal sl and ascii value of current character
         let &stl="%F %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%r%=%b\ 0x%B\ \ %l,%c%V\ %P  %=#%n %l/%L,%c%V"
      endif
   endfunc
   " Switch between the normal and vim-debug modes in the status line
   nmap _ds :gall SetStatusLineStyle()<CR>
   call SetStatusLineStyle()
   " Window title
   if has('title')
      set titlestring=%t%(\ [%R%M]%)
   endif
endif
" }}}

" syntax highlighting
syntax on

" Just load it. Don't use it, necessarily
source $HOME/notes/syntax.vim

filetype plugin indent on

" default comment symbols
let g:StartComment="#"
let g:EndComment=""

highlight Cursor gui=reverse guifg=NONE guibg=NONE
set guicursor=i-n-v-c:block-Cursor
set guicursor+=i-n-v-c:ver100-Cursor
set guicursor+=i-n-v-c:blinkon0

set keymap=dvorak
"set keymap=fastdvorak
set imsearch=0

" enable mouse support (all)
set mouse=a

silent! set ttymouse=xterm2
"silent! set ttymouse=xterm " no drag feedback but faster and less terminal codes and no glitches due to slowness

set notimeout
set nottimeout
set nocscopeverbose

"old glib syntax
let glib_enable_deprecated = 1
let glib_deprecated_errors = 1

set foldexpr=FoldBrace()
"set foldmethod=expr

" scrollbinding works vertically as well as horizontally
set scrollopt=ver,jump,hor

if ! &diff
    silent! setlocal autochdir
endif

"for gf(go file)
"doesn't work with overrided gf function
set path+=../
set path+=../../
set path+=../../../
set path+=../../../../
set path+=../../../../../
set path+=../../../../../../
set path+=../../../../../../../
" recursive
"set path+=**

" }}}

" cinoptions
" {{{
set cino+=(0
set cino+=:0
set cino+=g0
" }}}

" functions/commands
" {{{

" open files with globbing
" {{{
command! -complete=file -nargs=+ Etabs call s:ETW('tabnew', <f-args>)
command! -complete=file -nargs=+ Ewindows call s:ETW('new', <f-args>)
command! -complete=file -nargs=+ Evwindows call s:ETW('vnew', <f-args>)
command! -complete=file -nargs=+ Ebuffers call s:ETW('argadd', <f-args>)

function! s:ETW(what, ...)
  for f1 in a:000
    let files = glob(f1)
    if files == ''
      execute a:what . ' ' . escape(f1, '\ "')
    else
      for f2 in split(files, "\n")
        execute a:what . ' ' . escape(f2, '\ "')
      endfor
    endif
  endfor
endfunction
" }}}

" toggle quickfix window
" {{{
function! s:qf_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfunction

command! Ctoggle call s:qf_toggle()
" }}}

function! OpenFoldOnRestore()
  if exists("b:doopenfold")
    execute "normal zv"
    if(b:doopenfold > 1)
        execute "+".1
    endif
    unlet b:doopenfold
  endif
endfunction

function! SphinxSearch(cmd)
    " Use stdin here instead
    " silent! call system('vim-search-open-files-tmux.sh '.escape(shellescape(a:cmd),'"'))

    silent! call system('sphinx iname', a:cmd))
endfunction

function! SphinxSearchExact(cmd)
    " silent! call system('vim-search-exact-open-files-tmux.sh '.escape(shellescape(a:cmd),'"'))

    silent! call system('sphinx name', a:cmd))
endfunction

function! RunInTmux(cmd)
    "let session = system('get-tmux-from-pid.sh '.getpid()." | awk '{print $2}'")
    "silent! call system('tmux neww -n "vim-bash" "source ~/.bash_aliases;eval '.escape(shellescape(a:cmd),'"').'"')
    "call system('TMUXFROM='.g:tmuxsession.' tnw -icmd', escape(shellescape(a:cmd),'"'))
    " this should not have been prefixed with TMUXFROM. work it out
    " from the pid iff it's not given. every time. don't give it
    " every time. i think that's what broke it.

    call system('tnw -icmd', a:cmd)

    " silent! call system('tm -d sph -pak -args eval '.escape(shellescape(a:cmd.'; pak;'),"\""))

    "silent! call system('TMUXFROM='.g:tmuxsession.' tnw -icmd', escape(shellescape(a:cmd),'"'))
endfunction

function! RunInTmuxHSplit(cmd)
    call system('tmwh -icmd', a:cmd)
endfunction

function! RunInTmuxQueue(cmd)
    " Can probably remove these escapes too
    silent! call system('tsp -f vim-run-in-tmux-queue.sh '.escape(shellescape(a:cmd),'"').' & disown')
endfunction

function! RunInTmuxAnykey(cmd)
    silent! call system('tnw -icmd', escape(shellescape('pak; '.a:cmd),'"'))
endfunction

function! RunInTmuxNoQuit(cmd)
    silent! call system('tnw -icmd', escape(shellescape(a:cmd.'; pak;'),"\""))
endfunction

" 'super retab' commands
"
" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

function! s:DiffWithSaved()
  let filetype=&filetype
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro filetype=" . filetype
endfunction

command! DiffSaved silent! call s:DiffWithSaved()

fun! ToggleOpt(opt)
    exec 'windo set '.a:opt.'!'
    exec 'set '.a:opt.'?'
endf

function! MapToggle(key, opt)
    let savepos = getpos('.')
    let cmd = ':call ToggleOpt("'.a:opt.'")<CR>'
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
    call setpos('.', savepos)
    "echom a:opt
endfunction

" this was the original function. it no longer works either
"function! MapToggle(key, opt)
"  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
"  exec 'nnoremap '.a:key.' '.cmd
"  exec 'inoremap '.a:key." \<C-O>".cmd
"endfunction

command! -nargs=+ MapToggle call MapToggle(<f-args>)

function! ToggleKeymap()
    if &keymap == ""
        set keymap=dvorak
        set imsearch=0
        echom "dvorak"
    elseif &keymap == "dvorak"
        set keymap=colemak
        set imsearch=0
        echom "colemak"
    elseif &keymap == "colemak"
        set keymap=dvorak-german
        set imsearch=0
        echom "dvorak-german"
    else
        set keymap=
        set iminsert=0
        echom "qwerty"
    endif
endfunction

" automatically give executable permissions if file begins with #! and contains
" '/bin/' in the path
"use function! not function to overwrite
function! ModeChange()
  if getline(1) =~ "^#!"
      silent !chmod a+x %
  endif
endfunction

"let mapleader=","

function! FoldBrace()
  if getline(v:lnum+1)[0] == '{'
    return '>1'
  endif
  if getline(v:lnum)[0] == '}'
    return '<1'
  endif
  return foldlevel(v:lnum-1)
endfunction

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

augroup automatic_noeol
  au!
  au BufWritePre  * call <SID>TempSetBinaryForNoeol()
  au BufWritePost * call <SID>TempRestoreBinaryForNoeol()
augroup END

function! s:TempSetBinaryForNoeol()
  let s:save_binary = &binary
  if ! &eol && ! &binary
    let s:save_view = winsaveview()
    setlocal binary
    if &ff == "dos" || &ff == "mac"
      if line('$') > 1
        undojoin | exec "silent 1,$-1normal! A\<C-V>\<C-M>"
      endif
    endif
    if &ff == "mac"
      undojoin | %join!
      " mac format does not use a \n anywhere, so we don't add one when writing
      " in binary (which uses unix format always). However, inside the outer
      " if statement, we already know that 'noeol' is set, so no special logic
      " is needed.
    endif
  endif
endfunction

function! s:PreviousChange()
    if &diff
        normal [c
    else
        normal [h
    endif
endfunction
command! PreviousChange call s:PreviousChange()

function! s:NextChange()
    if &diff
        normal ]c
    else
        normal ]h
    endif
endfunction
command! NextChange call s:NextChange()

function! s:TempRestoreBinaryForNoeol()
  if ! &eol && ! s:save_binary
    if &ff == "dos"
      if line('$') > 1
        " Sometimes undojoin gives errors here, even when it shouldn't.
        " Suppress them for now...if you can figure out and fix them instead,
        " please update http://vim.wikia.com/wiki/VimTip1369
        silent! undojoin | silent 1,$-1s/\r$//e
      endif
    elseif &ff == "mac"
      " Sometimes undojoin gives errors here, even when it shouldn't.
      " Suppress them for now...if you can figure out and fix them instead,
      " please update http://vim.wikia.com/wiki/VimTip1369
      silent! undojoin | silent %s/\r/\r/ge
    endif
    setlocal nobinary
    call winrestview(s:save_view)
  endif
endfunction

" return output of ex command (so can save to variable)
funct! Exec(command)
    redir =>output
    silent exec a:command
    redir END
    return output
endfunct!

" output of ex command into new buffer
function! Message(cmd)
  redir => message
  silent execute a:cmd
  redir END
  "vsplit
  enew
  silent put=message
  set nomodified

  call Ns(a:cmd)
endfunction
command! -nargs=+ -complete=command Message call Message(<q-args>)

function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  tabnew
  silent put=message
  set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" removes buffers with [No Name] so that functions like grep do not act
" on them
function! CleanEmptyBuffers()
  let buffers = filter(range(0, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0')
  if !empty(buffers)
    exe 'bw '.join(buffers, ' ')
  endif
endfunction

function! Execute(cmd)
  redir => output
  execute a:cmd
  redir END
  return output
endfunction

"function EmulateLeftClick()
"    let c = getchar()
"    if c == "\<LeftMouse>" && v:mouse_win > 0
"        exe v:mouse_win . "wincmd w"
"        exe v:mouse_lnum
"        exe "normal " . v:mouse_col . "|"
"    endif
"endfunction

function! ReopenInVim()
    if &modified
        "bnum=bufnr('%')
        only
        DiffSaved
        echo "File is modified, can't reopen. Fix changes and save"
    else
        silent! let path=expand('%:p')
        silent! let cline=line(".")
        silent! let ccol=col(".")
        "silent! windo bd!
        silent! windo call Bclose()!
        " GitGutter stops working in the next vim instance when inside a
        " difftool vimdiff because difftool is still running.
        "silent! exec "!clear;vim +".cline." +\"call cursor(0, ".ccol.")\" \"".escape(path,"#")."\""
        " Instead, kill the shell first then run next command.
        silent! exec "!clear;vim +".cline." +\"call cursor(0, ".ccol.")\" \"".escape(path,"#")."\""
        "silent! exec "!clear;tmux-vim.sh +".cline." +\"call cursor(0, ".ccol.")\" \"".escape(path,"#")."\""
        "silent! exec "!clear;vim +".cline." \"".path."\""
        silent! quit!
    endif
endfunction
command! ReopenInVim call ReopenInVim()

" }}}

" fix annoying keymaps
" {{{
source $VAS/source/git/config/vim/fixkeymaps-vimrc

" }}}

" keymaps / mappings
" {{{

source ~/.vimmaprc

" This overrides a folding mapping
"
" This is still an important mapping because the vim you are currently
" running may have been given extra command-line options, such as
" disabling autochdir and you'd like to reopen the file as if vim had
" been started normally.
nmap Zv ;ReopenInVim<CR><C-w>p

"imap p <C-r>*
"inoremap p s<C-o>:set paste<CR><C-h><C-r>*<C-o>:set nopaste<CR>
"imap p s<C-h><C-r>*

fun! NormalSplitting()
    let g:hidecolums = 0
    set noscrollbind 
endf

fun! NormalSplitThenTagbarToggle()
    call NormalSplitting()
    TagbarToggle
endf

"nmap <leader>tb ;TagbarOpen fj<CR>
nmap <leader>tb ;call NormalSplitThenTagbarToggle()<CR>
nnoremap <C-w>s :call NormalSplitting()<CR><C-w>s
nnoremap <C-w>o :call NormalSplitting()<CR><C-w>o

nnoremap <leader>um :%!mnm<CR>
xnoremap <leader>um :!mnm<CR>
nnoremap <leader>uu :%!umn<CR>
xnoremap <leader>uu :!umn<CR>

function! InsertPaste(before)
    let pos=getpos(".")
    let win=winsaveview()
    if getline(".") =~ '^$' || a:before
        normal! P
    else
        normal! p
        let pos[2]+=1
    endif
    "call winrestview(win)
    "call setpos(".",pos)
    startinsert
endfunction

"Sometimes strings from the clipboard do not end in an end of string character.
"If the clipboard does not hand EOLs, then paste will hang. This will
"prevent that.

" Keep these on
inoremap p s<C-h><left><C-o>:call InsertPaste(0)<CR>
inoremap P s<C-h><C-o>:call InsertPaste(1)<CR>

" The problem is not vim. It's bad data in the clipboard
" If I paste in emacs, or enable the following bindings, it's easy to
" see

" The InsertPaste function is meant for insert mode
"nnoremap p :exe expand("normal! a\<C-R>=system('xc | cat')\<CR>")<CR>
"nnoremap P :exe expand("normal! i\<C-R>=system('xc | cat')\<CR>")<CR>
"nnoremap p :exe expand("normal! a\<C-R>=system('xc | cat')\<CR>")<CR>
"nnoremap P :exe expand("normal! i\<C-R>=system('xc | cat')\<CR>")<CR>

nmap <C-^> ;echo "USE gl, ca OR cm"<CR>

nnoremap ca <C-^>

" Don't want this. I want vim-commentary instead.
" nnoremap cm <C-^>

nnoremap Z? :Message map<CR>

" select next and previous paragraph
nmap ]p }<Space>vip
nmap [p {<BS>vip
nmap [o [p
nmap ]o ]p
xmap ]p <Esc>}<Space>vip
xmap [p <Esc>{<BS>vip
xmap [o [p
xmap ]o ]p

function! EasySave()
    if expand("%:p:h") =~ g:mygit.'/config/vim/common/bundle/vim-snippets/snippets'
        RetabIndent
    endif
    
    try
        wa
        "echom 'Saved   **'.strftime("%c").'**   :) '
        "echom 'EasySave()   '.strftime("%c").'   :) '
    catch 
        echom "Could not save. Read-only?"
    endtry
endfunction

function! AsyncSave()
    silent! wa

    echom 'Saved normally   '.strftime("%c").'   :) '

    return
    "echom 'Saved   '.strftime("%c").'   :) '
    try
        silent! normal ;silent! w! !tmux-async-run-stdio.sh 'sponge > %:p' &>/dev/null
    catch 
        pass
    endtry
    return
    try
        "silent! normal ;wa
        "ycye!ycP
        silent! normal ;w! !tmux-async-run-stdio.sh 'sponge %:p'
        "echom 'Saved   **'.strftime("%c").'**   :) '
        echom 'Saved   '.strftime("%c").'   :) '
    catch 
        echom "Could not save. Read-only?"
    endtry
endfunction

nnoremap <leader>um :%!mnm<CR>
"save with M-; M-;
"cmap ; call EasySave()<CR>
"cmap w call EasySave()<CR>
cmap ; wa!<CR>
cmap w w!<CR>
"cnoremap <silent> ; :silent! wa<CR>
cmap <silent> l silent! call AsyncSave()<CR>
"cnoremap <silent> l :silent! wa<CR>

" reopen
cmap <silent> k <C-c>;silent! e!<CR>

"quit with M-; M-o
cmap <silent> o <C-c>;silent! qa!<CR>

" quit vim when using with ranger
cmap  o

" open in full vim (not fastvim)
" need gv for saving and restoring visual selection
"map gv ;silent! bdelete | silent! !bash -c "gvim.sh % &disown" | execute ';redraw!'

" select pasted text
nnoremap viP `[v`]

fun! RunBlame()
    exe "call TmuxSplitV(\"magit blame \\\"".expand("%")."\\\"\")"
    Gblame
endf

nnoremap <Leader>gs :Gstatus<CR>
" nnoremap <Leader>gb :Gblame<CR>
" nnoremap <Leader>gb :exe "call TmuxSplitV(\"magit blame \\\"".expand("%")."\\\"\")"<CR>
nnoremap <Leader>gb :call RunBlame()<CR>

"nmap <Delete> ;bdelete!<CR>
" Stop delete key from deleting the buffer
" Because it is bound to C-M-u in tmux
"nmap <Delete> <NOP>

" Make C-g from inside command mode work like emacs, in that in
" cancels any current operation.
cmap  

"nmap yc ggVGy
nmap yc ggVG

map  <left>
map  <right>
map  <up>
map <C-J> <down>

" having these are more important than being able to quickly enter
" easymotion.
imap  <left>
imap  <right>
imap  <up>
imap <C-J> <down>

" important fix (hopefully there are no escape code conflicts)
imap $ l$

"" Emacs-like line inserts (not sure if there is a way already)
" nnoremap <ESC>, a<CR><ESC>
" nnoremap <ESC>< i<CR><ESC>

" gf always opens even if file doesnt exist
" " this has been superceeded in gf_ext.vim
"noremap gf :e <cfile><CR>

xnoremap t lt
xnoremap T hT

"xnoremap $ $h
xnoremap $ g_
xnoremap g_ $

xnoremap . s<C-R>.

" the commented bit doesn't work unfortunately
"set <M-C-h> <C-h>
"inoremap <M-C-h> <Left>
inoremap <C-h> <Left>

" These two lines prevents mistakes when doing o<M-$> to insert a new
" line starting with $
" Make more of these, so that can hold down M more often -- more
" comfortable.
" These symbols are of importance because of how the left hand uses them
" !@#$
" Not sure why @ needs to work differently
if ! has('nvim')
    " Only works in vim, not nvim
    set <M-$>=$
endif
" need this for going to the end of a line after editing something.
"inoremap <M-$> $
nnoremap <M-$> $
xnoremap <M-$> <ESC>$

" don't want to do ^

nmap <C-w>h <C-w>h
nmap <C-w>l <C-w>l
nmap <silent> g<C-w>k ;let linenum=getpos('.')[1]\|:wincmd k\|;call cursor(linenum,0)<cr>
nmap <silent> g<C-w>i ;let linenum=getpos('.')[1]\|:wincmd i\|;call cursor(linenum,0)<cr>
nmap <silent> g<C-w>h ;let linenum=getpos('.')[1]\|:wincmd h\|;call cursor(linenum,0)<cr>
nmap <silent> g<C-w>l ;let linenum=getpos('.')[1]\|:wincmd l\|;call cursor(linenum,0)<cr>
nmap <silent> <C-w><down> ;let linenum=getpos('.')[1]\|:wincmd k\|;call cursor(linenum,0)<cr>
nmap <silent> <C-w><up> ;let linenum=getpos('.')[1]\|:wincmd i\|;call cursor(linenum,0)<cr>
nmap <silent> <C-w><left> ;let linenum=getpos('.')[1]\|:wincmd h\|;call cursor(linenum,0)<cr>
nmap <silent> <C-w><right> ;let linenum=getpos('.')[1]\|:wincmd l\|;call cursor(linenum,0)<cr>
nmap <silent> <C-w>w ;let linenum=getpos('.')[1]\|:wincmd w\|;call cursor(linenum,0)<cr>
nmap <silent> <C-w><C-w> <C-w>w

"" Do I really want this? hidecolumns closes other buffers. not just
"" columns
"fun! CloseWindow()
"    let g:hidecolums = 1
"    normal! <C-w>c
"endf
"nnoremap <silent> <C-w>c :call CloseWindow()<CR>

nnoremap vi$ ^v$h<C-o>echom "Use Y"<CR>

nmap <silent> ZP Y"zy;call SphinxSearch(@z)<CR>
xmap <silent> ZP "zy;call SphinxSearch(@z)<CR>

nmap <silent> Z{ Y"zy;call SphinxSearchExact(@z)<CR>
xmap <silent> Z{ "zy;call SphinxSearchExact(@z)<CR>

fun! YRun()
    normal Y"zy
    call RunInTmux(@z)
endf

" Execute line/selection in bash
" using nnoremap (for : instead of ;) seems to only work on the first time i press ZX
" this has not fixed the problem. what is causing it to only run once?
nmap ZX ;call YRun()<CR>
xmap ZX "zy;call RunInTmux(@z)<CR>
"nmap <silent> ZX ;normal Y<CR>"zy;call RunInTmux(@z)<CR>
"xmap <silent> ZX "zy;call RunInTmux(@z)<CR>

" Make this run in a right split 
nmap <silent> Zxc Y"zy;call RunInTmux(@z)<CR>
xmap <silent> Zxc "zy;call RunInTmux(@z)<CR>

nmap <silent> Z: Y"zy;call RunInTmuxQueue(@z)<CR>
xmap <silent> Z: "zy;call RunInTmuxQueue(@z)<CR>
nmap <silent> Zxf Y"zy;call RunInTmuxAnykey(@z)<CR>
xmap <silent> Zxf "zy;call RunInTmuxAnykey(@z)<CR>
"nmap Zx ;echo "USE ZX"<CR>
"xmap Zx <ESC>;echo "USE ZX"<CR>


nmap <silent> g/ ;call RunInTmux("note fs edit \"".expand("%:pj")."\"")<CR>
nmap <silent> g? ;call RunInTmux("note fs edit \"".matchstr(expand("%:pj"),"^.*/")."\"")<CR>
"nmap <silent> g<space> ;call RunInTmux("note fs view \"".matchstr(expand("%:pj"),"^.*/")."\" \| less -S")<CR>
nmap <silent> g<space> ;call RunInTmux("note fs view \"".expand("%:pj")."\"")<CR>


" I want lazyredraw to work when these happen! But it doesn't!
" This still runs a lot faster than simply mapping <C-o> to <C-o>zz
function! BackJump()
    exec "normal! 1\<C-o>fzz"
endfunction

function! ForwardJump()
    exec "normal! 1\tzz"
endfunction

nnoremap <C-o> :call BackJump()<CR>
nnoremap <C-i> :call ForwardJump()<CR>
"try to get <C-i><C-i> doing forward jump (havent found a way yet)
" the prob is it's the same as tab

" when in normal mode, I want space to be like PgDn
" <Space> is useful. it goes to the next character and doesn't stop at
" the end of the line.
"nmap <Space> <C-d>
nmap <End> ZQ
nmap <kEnd> ZQ
nmap <Home> ;wall<CR>
"nmap - ;w!<CR>
"nmap = ;dbelete!<CR>
" <BS> is useful. it goes to the previous character and doesn't stop at
" the beginnign of the line.
"nmap <BS> ;e!<CR>
nmap Z<BS> ;e!<CR>
nmap Zd ;DiffSaved<CR>

nmap zM zMzz


if !exists("g:ncolumns")
    let g:ncolumns=1
endif

" these function allows you to put a number prefix before <C-u>, which
" means before <C-b> as well in our case.
" Note: The <C-U> is required to remove the line range that you get when
" typing ':' after a count.
function! ScrollUp(count)
    let c=count * g:ncolumns
    if ! c > 0
        let c=1
    endif
    let c = c * 2
    for i in range(1, c)
        exec "normal! \<C-u>"
    endfor
endfunction
function! ScrollDown(count)
    let c=count * g:ncolumns
    if ! c > 0
        let c=1
    endif
    let c = c * 2
    for i in range(1, c)
        exec "normal! \<C-d>"
    endfor
endfunction
function! HalfscrollUp(count)
    let c=count * g:ncolumns
    if ! c > 0
        let c=1
    endif
    for i in range(1, c)
        exec "normal! \<C-u>"
    endfor
endfunction
function! HalfscrollDown(count)
    let c=count * g:ncolumns
    if ! c > 0
        let c=1
    endif
    for i in range(1, c)
        exec "normal! \<C-d>"
    endfor
endfunction

nnoremap <silent> <C-u> :<C-U>call HalfscrollUp(v:count1)<CR>
nnoremap <silent> <C-d> :<C-U>call HalfscrollDown(v:count1)<CR>
nnoremap <silent> <C-b> :<C-U>call ScrollUp(v:count1)<CR>
nnoremap <silent> <C-f> :<C-U>call ScrollDown(v:count1)<CR>
nnoremap <silent> <pageup> :<C-U>call ScrollUp(v:count1)<CR>
nnoremap <silent> <pagedown> :<C-U>call ScrollDown(v:count1)<CR>
"nmap <pageup> ;PreviousChange<CR>zz
"nmap <pagedown> ;NextChange<CR>zz

nnoremap y/ /<up><C-f><left>v0y<C-c><C-c>
nmap 1<C-g> ;echo expand('%:p')<CR>
nmap 2<C-g> ;echo @%<CR>

" allows you to put the z register into the clipboard instead of
" highlighting all that again

nmap zy ;let @*=@z<CR>

" Overridden in goto-definition.vim
nmap <2-LeftMouse> *
xmap <2-LeftMouse> *

nmap <RightMouse> *
xmap <RightMouse> *

"" This was driving me insane
"" xmap <RightMouse> "zy;CtrlPLine<CR><C-r><C-\>rZ
"" Yay it does nothing now
"xmap <RightMouse> <NOP>

"nmap <RightMouse> ;call EmulateLeftClick()<CR>

""nmap <RightMouse> ;!xdotool click 1<CR>;call StartCheckSameSearchHighlight("vit")<CR>
"nmap <RightMouse> ;let x = system('bash -c "sleep 1 && xdotool click 1 &"')<CR>
""zy;CtrlPLine<CR><C-r><C-\>rZ


"function! SearchNotLineStartingWith(pattern)
"endfunction
"
xmap gU "zy;LocateFile <C-R>z<CR>
nmap gU ;LocateFile 
xmap gu "zy;LocateEdit <C-R>z<CR>
nmap gu ;LocateEdit 
nmap ch ;bprev<CR>
nmap cl ;bnext<CR>
nmap gt gt

"nmap n nzz
"nmap N Nzz
"i actually think it's more natural to not zz when searching
"backwards.
"actually, im disabling both of those
" xmap n *nzz " This breaks searching next match while selecting a
" paragraph
" as a rule, reduce the amount of screen updating. it's confusing

nmap gd gdzt

vmap gd *gg0n
"vmap gd <Esc>gdzt

function! MovePercent(signedpercent, mode)
    if a:mode ==# 'v'
        normal! gv
    endif

    let step = max([abs(a:signedpercent) * winheight(0) / 100, 1])
    if a:signedpercent < 0
        for i in range(1,step)
            exec "normal! \<C-e>"
        endfor
    elseif a:signedpercent > 0
        for i in range(1,step)
            exec "normal! \<C-y>"
        endfor
    endif
endfunction

"nnoremap <C-t> <C-y>
"nnoremap <C-e> :silent! call MovePercent(-10)<CR>
"nnoremap <C-t> :silent! call MovePercent(10)<CR>

nnoremap <ScrollWheelUp> 6<C-y>
map <S-ScrollWheelUp> 6<C-U>
nnoremap <ScrollWheelDown> 6<C-e>
map <S-ScrollWheelDown> 6<C-D>

function! OpenClipInWin()
    " let cmd = "tmux-vim-pipe-bg.sh ".&ft
    " If it's quickfix then fzf won't work. Since I'm not using syntax
    " highlighing now anyway, I should just set to text
    let cmd = "tm -f -S -tout -i nw v"
    silent! call system(cmd, @z)
endfunction
xmap <CR> "zy;silent! call OpenClipInWin()<CR>"
"xmap <CR> "zy;call system('echo '.shellescape(@z).' \| tmux-vim.sh -c "set ft='.&ft.'"')<CR>

" Will get a segfault with -nosplash
nmap Ze ;silent! !eclipse-edit.sh "%:p"<CR><C-l>

nmap Zm ;silent! !mousepad "%:p" &>/dev/null & disown<CR><C-l>

"nmap ZJ ;ls<CR>
"nmap Zt ;mksession! $SESSION_FILE<CR>
xmap Zgd "zy;silent! !CWD="%:p:h";result="${CWD\#\#*/}";tmux neww -c "%:p:h" -n "δ-<C-r>z" "CWD=\"%:p:h\" zsh -c \"git difftool <C-R>"\\^\!\""<CR>
nmap Zgd vit"zy;silent! !CWD="%:p:h";result="${CWD\#\#*/}";tmux neww -c "%:p:h" -n "δ-<C-r>z" "CWD=\"%:p:h\" zsh -c \"git difftool <C-R>"\\^\!\""<CR>
" Find file in repo using ack
xmap ZO "zy;silent! AckFile! '<C-R>z' "`git rev-parse --show-toplevel`"<CR>
" Find file in project using CtrlP
nmap Zgf viq"zy;CtrlP<CR><C-\>rZ
xmap Zgf "zy;CtrlP<CR><C-\>rZ
" Grep buffers using CtrlP

" see ruby's gd here
" ~/versioned/git/config/vim/vim/ftplugin/ruby.vim
" There is no way to grep repo using CtrlP
"nmap ZY vit"zy;CtrlPLine<CR><C-\>rZ
nmap ZY vit"zy;Lines<CR><C-\>rZ
"xmap ZY "zy;CtrlPLine<CR><C-\>rZ
xmap ZY "zy;Lines<CR><C-\>rZ
" Grep buffers using CtrlP regex
"nmap <C-s> ;CtrlPLine<CR>
"nmap <C-s> ;Lines<CR>
nmap <C-s> /
nmap ZM ;echo "USE <C-s>"<CR>
"xmap ZM "zy;CtrlPLine<CR><C-r><C-\>rZ
xmap ZM "zy;Lines<CR><C-r><C-\>rZ
" Grep files in repo using ack
nmap ZN ;silent! AckFromSearch! "`git rev-parse --show-toplevel`"<CR>
" this relies on the new * mapping
xmap ZN *ZN
"would be nice if quickfix auto-updated, but this doesn't really work
"and is also laggy
"nmap [u ;cprev<bar>Ctoggle<bar>Ctoggle<CR>
nmap [u ;cprev<CR>
nmap ]u ;cnext<CR>
nmap [e ;ERRP<CR>
nmap ]e ;ERR<CR>
nmap [/ 0;COMP<CR>
nmap ]/ $;COM<CR>
nmap ZU ;Ctoggle<CR>
"nmap ZI ;bd!<CR>

function! BufJumpDelete()
    exe "jd ^=expand('%:p')<CR>$"
    "bdelete
    call Bclose()
endfunction

function! XMLFormat()
    exe "%!xmllint --encode UTF-8 --format - 2>/dev/null"
endfunction

command! XMLFormat call XMLFormat()

function! AckTop(pattern)
    set hls
    let path = system('get-project-dir.sh')
    " The ! makes it so ack doesn't open the first file it finds
    exe 'silent! let @/="'.a:pattern.'" | Ack! -- ' . a:pattern . ' ' . path
    silent! cclose
    exe "silent! below copen ".(winheight(0) / 2)
    set modifiable
    %!mnm
endfunction
command! -nargs=+ AckTop call AckTop(<q-args>)

nmap Zu ;set syntax=underscore_template<CR>

" improve this. it's not possible to do an automatic <Tab> expand here

" Ack
" Reasons to use ack-grep vs grep
" ∙ Blazingly fast
"       Only searches stuff that makes sense to search.
" ∙ Better search
"       Searches entire trees by default while ignoring Subversion, Git
"       and other VCS directories and other files that aren't your
"       source code.
" ∙ Designed for code search
"       Where grep is a general text search tool, ack is especially for
"       the programmer searching source code. Common tasks take fewer
"       keystrokes.

" grep
    " Search current directory
        " copied text
        nmap ZH ;silent! Ack! '<C-R>"' "%:p:h"<CR>
        " selected text
        xmap ZH "zy;silent! Ack! '<C-R>z' "%:p:h"<CR>
        "xmap ZJ "zy;silent! !CWD="%:p:h";result="${CWD\#\#*/}";tmux neww -c "%:p:h" -n "grep" "CWD=\"%:p:h\" zsh -c \"tmux-grep-from-top-git.sh '<C-R>z' regex-insensitive\""<CR>
        "nmap ZJ ;silent! !CWD="%:p:h";result="${CWD\#\#*/}";tmux neww -c "%:p:h" -n "grep" "CWD=\"%:p:h\" zsh -c \"tmux-grep-from-top-git.sh '' regex-insensitive\""<CR>

    " In new window, search git repository
        " case-insensitive
        xmap ZI "zy;silent! !CWD="%:p:h";result="${CWD\#\#*/}";tmux neww -c "%:p:h" -n "grep" "CWD=\"%:p:h\" zsh -c \"tmux-grep-from-top-git.sh '<C-R>z' insensitive\""<CR>
        nmap ZI ;silent! !CWD="%:p:h";result="${CWD\#\#*/}";tmux neww -c "%:p:h" -n "grep" "CWD=\"%:p:h\" zsh -c \"tmux-grep-from-top-git.sh '' insensitive\""<CR>
        " regex with template
        xmap ZR "zy;silent! !CWD="%:p:h";result="${CWD\#\#*/}";tmux neww -c "%:p:h" -n "grep" "CWD=\"%:p:h\" zsh -c \"tmux-grep-from-top-git.sh '<C-R>z' regex-template\""<CR>
        " regex
        nmap ZR ;silent! !CWD="%:p:h";result="${CWD\#\#*/}";tmux neww -c "%:p:h" -n "grep" "CWD=\"%:p:h\" zsh -c \"tmux-grep-from-top-git.sh '' regex\""<CR>
        " plain
        nmap ZF ;AckTop 
        xmap ZF y;let @/ = @"<bar>AckTop <C-R>"<CR> 
        xmap ZG "zy;silent! !CWD="%:p:h";result="${CWD\#\#*/}";tmux neww -c "%:p:h" -n "grep" "CWD=\"%:p:h\" zsh -c \"tmux-grep-from-top-git.sh '<C-R>z' ''\""<CR>
        " plain, already copied
        nmap ZG ;silent! !CWD="%:p:h";result="${CWD\#\#*/}";tmux neww -c "%:p:h" -n "grep" "CWD=\"%:p:h\" zsh -c \"tmux-grep-from-top-git.sh '' ''\""<CR>

" shell
    " Open new      window in current directory
    " nmap <silent> ZB ;silent! !tm -f -d nw -c "%:p:h" zsh &<CR>
    " Open new wide window in current directory
    " nmap <silent> ZC ;silent! !tm -f -d sph -c "%:p:h" zsh &<CR>
    " Open new tall window in current directory
    " nmap <silent> ZV ;silent! !tm -f -d spv -c "%:p:h" zsh &<CR>
    "" Open new tall ranger in current directory
    "nmap ZL ;silent! !tmux-vim-split.sh "%:p:h" -r &<CR>

    " Super quiet versions.
    noremap <silent> ZB :call system("tm -f -d nw -c \"".expand('%:p:h')."\" zsh &")<CR>
    noremap <silent> ZC :call system("tm -f -d sph -c \"".expand('%:p:h')."\" zsh &")<CR>
    noremap <silent> ZV :call system("tm -f -d spv -c \"".expand('%:p:h')."\" zsh &")<CR>

"nmap Zr ;silent! !CWD="%:p:h";result="${CWD\#\#*/}";tmux splitw -h -c "%:p:h" "source ~/.profile; CWD=\"%:p:h\" bash -c "./%"\|less"<CR>

function! SchemaInTmux()
    silent! call TmuxBaseWait()
    silent! call system('tm -f -te -d sph -c "'.fnameescape(expand('%:p:h')).'" "zh '.fnameescape(expand('%:p')).'"'))
endfunction

nnoremap <silent> Zh :call SchemaInTmux()<CR>
xnoremap <silent> Zh <ESC>:call SchemaInTmux()<CR>

function! ExecInTmux()
    silent! call TmuxBaseWait()
    silent! call system('tm -f -te -d spv -c "'.fnameescape(expand('%:p:h')).'" "cr '.fnameescape(expand('%:p')).'"'))
endfunction

nnoremap <silent> Zr :call ExecInTmux()<CR>
xnoremap <silent> Zr <ESC>:call ExecInTmux()<CR>

function! ExecInTmuxDebug()
    silent! call TmuxBaseWait()
    silent! call system('rifle-run-split.sh -b "'.expand('%:p').'"'))
endfunction

nnoremap <silent> Zb :call ExecInTmuxDebug()<CR>
xnoremap <silent> Zb <ESC>:call ExecInTmuxDebug()<CR>

" this command runs the current line in bash
" this does the equivalent of selecting a line with Y
" see http://goo.gl/shpJrm

" unhighlight word under cursor
fun! UnLightUpCurrent()
    if &ft != 'fugitiveblame'
        match IncSearch ''
    endif
endf

" highlight word under cursor
fun! LightUpCurrent()
    if &ft != 'fugitiveblame'
        exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    endif
endf

autocmd CursorMoved * call LightUpCurrent()
" useful but too distracting
"autocmd CursorMoved * call UnLightUpCurrent()
"autocmd CursorMovedI * call UnLightUpCurrent()
"autocmd CursorHold * call LightUpCurrent()
"autocmd CursorHoldI * call LightUpCurrent()

" fun! NarrowWrap()
    " call NormalSplitting()
    " exe "normal \<Plug>Narrow"
" endf

" fun! NarrowDiffWrap()
    " call NormalSplitting()
    " exe "normal \<Plug>NarrowAndDiff"
" endf

nmap <silent> Zl ;silent! .w !bash &>/dev/null<CR>
" xmap N ;call NarrowWrap()<CR>
" xmap D ;call NarrowDiffWrap()<CR>

" This can't be used for narrow because N is used for 'repeat search backwards'.
"xmap N <Plug>Narrow
" No matter what, anything bound to <Plug>Narrow is quite buggy
" This has fixed the narrow command. It can be bound to anything
function Narrow(mode)
    if a:mode ==# 'v'
        normal! gv
    endif

    execute "normal \<Plug>Narrow"
endfunction
xnoremap <leader>n :<C-u>call Narrow('v')<CR>

" xmap <leader>N call <Plug>Narrow
"xmap <leader>N <Plug>Narrow
"xmap <leader>N Narrow
xmap D <Plug>NarrowAndDiff

map w <Plug>CamelCaseMotion_w
map b <Plug>CamelCaseMotion_b
map e <Plug>CamelCaseMotion_e
omap iw <Plug>CamelCaseMotion_iw
xmap iw <Plug>CamelCaseMotion_iw
omap ib <Plug>CamelCaseMotion_ib
xmap ib <Plug>CamelCaseMotion_ib
omap ie <Plug>CamelCaseMotion_ie
xmap ie <Plug>CamelCaseMotion_ie
nmap cw ce
omap iw ie
xmap iw ie
nmap vit ;normal! viw<CR>
nmap vir ;call SelectWordAndDots()<cr>
nmap viq ;call SelectArgument()<cr>
" this approach interferes with camelcasemotion. instead add to the camelcasemotion regex.
"nmap viw ;call SelectWithoutHash()<cr>

"imap <C-w> ;set eventignore=InsertEnter,InsertLeavevlbs;set eventignore=
imap <C-w> vlbs
nmap <C-w><C-c> <NOP>

" use the search register to find the next thing directly above or below
nmap ]> ;exe '/\%'.virtcol('.').'v'.@/<CR>
nmap [> ;exe '?\%'.virtcol('.').'v'<CR>
xmap ]> <C-c>;exe '/\%'.virtcol('.').'v'.@/<CR>mxgv`x
xmap [> <C-c>;exe '?\%'.virtcol('.').'v'.@/<CR>mxgv`x

" Find next
nmap ]? ;exe '/\%'.virtcol('.').'v\S'<CR>
nmap [? ;exe '?\%'.virtcol('.').'v\S'<CR>
xmap ]? <C-c>;exe '/\%'.virtcol('.').'v\S'<CR>mxgv`x
xmap [? <C-c>;exe '?\%'.virtcol('.').'v\S'<CR>mxgv`x

nmap <silent> <Leader>( ;Git diff HEAD\^\! -- %<CR><C-L>
"nmap <silent> <Leader>8 ;silent! !vc g commit-respawn <BAR> redraw!<CR>

function! AmendRespawn()
    !vc amend-respawn
    redraw!
endfunction

function! CommitRespawn()
    !vc commit-respawn
    redraw!
endfunction

" was: TmuxNeww
fun! TmuxNeww(incmd)
    let cmd = 'tm -f -S -t nw '.escape(fnameescape(a:incmd), "#%()")
    echom 'Running: '.cmd
    call system(cmd)
    "Message mess
endf

" was: TmuxNeww
fun! TmuxSplitV(incmd)
    let cmd = 'tm -f -S -t spv '.escape(fnameescape(a:incmd), "#%()")
    echom 'Running: '.cmd
    call system(cmd)
    "Message mess
endf

" was: TmuxNewwEdit
fun! TmuxSplitH(incmd)
    let cmd = 'tm -f -S -tout sph -c "'.expand("%:p:h").'" -xargs'

    w
    call system(cmd,a:incmd)
    e!
    echom 'Ran: '.cmd
    "Message mess
endf

nmap <silent> <Leader>7 ;silent! call AmendRespawn()<CR>
nmap <silent> <Leader>8 ;silent! call CommitRespawn()<CR>
nmap <silent> <Leader>9 ;Git difftool HEAD\^\! -- %<CR><C-L>
"nmap <silent> <Leader>; ;Git diff -- %<CR><C-L>
"nmap <silent> <Leader>: ;Git diff --cached -- %<CR><C-L>
nmap <silent> <Leader>; ;silent !difftool.sh<CR><C-L>
nmap <silent> <Leader>: ;silent !vimgstatus<CR><C-L>
"nmap <silent> <Leader>' ;silent !git d -- %<CR><C-L>
nmap <silent> <Leader>' ;silent! call TmuxSplitH('git d -- '.expand('%'))<CR>
nmap <silent> <Leader>" ;silent !git d --cached -- %<CR><C-L>
nmap <silent> <Leader>* ;silent !difftool.sh HEAD\^:<CR><C-L>

"nmap <silent> <Leader>= ;silent !git dp  %<CR><C-L>
"map <silent> <Leader>= ;<C-U>silent !git dp % v:count1<CR><C-L>

function! DiffPrevRev(count)
    exe "silent !git dp ".expand("%")." ".count
    redraw!
endfunction

command! -nargs=1 DiffPrevRev call DiffPrevRev(<args>)
map <silent> <Leader>= ;<C-U>DiffPrevRev(v:count1)<CR>


function! DiffMyLast()
    exe "silent !git-diff-last-commit-not-mine.sh"
    redraw!
endfunction
command! DiffMyLast call DiffMyLast()
map <silent> <Leader>f ;DiffMyLast<CR>

function! DiffMyLastThis()
    exe "silent !git-diff-last-commit-not-mine.sh -- ".expand("%")
    redraw!
endfunction
command! DiffMyLastThis call DiffMyLastThis()
map <silent> <Leader>l ;DiffMyLastThis<CR>

function! DiffSinceBranch(count)
    exe "silent !git pb ".expand("%")." ".count
    redraw!
endfunction

command! -nargs=1 DiffSinceBranch call DiffSinceBranch(<args>)
map <silent> <Leader>- ;<C-U>DiffSinceBranch(v:count1)<CR>

"function! SelectWithoutHash()
"    set iskeyword-=#
"    normal! viw
"    set iskeyword+=#
"endfunction

function! SelectWordAndDots()
    set iskeyword+=.
    set iskeyword+=-
    normal! viw
    set iskeyword-=.
    set iskeyword-=-
endfunction

" It would be nice if this function could work out what () it should
" select. I.e. You're selecting an argument inside a pair of parenthesis
" and the argument has parenthesis itself, so only select the pair
" belonging to the argument.
function! SelectArgument()
    set iskeyword+=.
    set iskeyword+=-
    set iskeyword+=[
    set iskeyword+=]
    "set iskeyword+== "why equals?
    set iskeyword+='
    set iskeyword+="
    normal! viw
    set iskeyword-=.
    set iskeyword-=-
    set iskeyword-=[
    set iskeyword-=]
    "set iskeyword-== "why equals?
    set iskeyword-='
    set iskeyword-="
endfunction

" insert css
function! ScratchBufOpen(filetype)
    new
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    exe 'setlocal filetype=' . a:filetype
    nnoremap <buffer> <leader>x :call ScratchBufClose()<cr>
endfunction

function! ScratchBufClose()
    normal! gg0vG$y
    bwipe
    normal! Pl
endfunction

nnoremap <leader>x :call ScratchBufOpen('css')<cr>


function! HTMLEncode()
    exe "%!htmlencode.sh"
    redraw!
endfunction

function! HTMLDecode()
    exe "%!htmldecode.sh"
    redraw!
endfunction

command! HTMLEncode :silent! call HTMLEncode()
command! HTMLDecode :silent! call HTMLDecode()

" counters the issue with smartindent that affects making comments in
" python (puts comment on the first column).
inoremap # X#

" go to last tab
"let g:lasttab = 1
"nnoremap gl :exe "tabn ".g:lasttab<CR>
"au TabLeave * let g:lasttab = tabpagenr()
" now does the same al C-6
nnoremap gl <C-^>

" use this before F7
inoremap <F2> <Esc>hl

function! QuitIfNoName()
    " if from stdin, i.e. [ No Name ]
    if bufname('%') == ''
        bd!
    endif
    bd " quit anyway
    q
endfunction

command! QuitIfNoName :silent! call QuitIfNoName()

" unmap annoying keys
nnoremap K <Nop>
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>
" remapped (was annoying) Q to quit is the some behavior as elinks.
nnoremap Q :QuitIfNoName<CR>
" This may prevent tab characters being inserted if tab completion does
" not work but it also disables tab completion.
"cnoremap <Tab> <Nop>

" This makes it faster to do ;<C-f> or ;<C-r>
"   -- can do <C-;><C-f>
"nnoremap <C-;> ;
nnoremap [27;5;59~ :

"nmap K ge
nnoremap ZQ :qa!<CR>

function! QuickfixClear()
    call setqflist([])
endfunction

so $VIMCONFIG/git.vim

fun! FZFGit()
    exe "Files ".GetGitDir()
endf

fun! FZFHere()
    exe "Files ."
endf

fun! FZFFindFile(count)
    exe "Files ".GetGitDir()
endf

" quicker buffer navigation
"nnoremap <C-n> :CtrlPBuffer<CR>
"git rev-parse --show-toplevel
"nnoremap <C-p> :FZF<CR>
" nnoremap <Esc>4 :call FZFGit()<CR>
nnoremap <Esc>7 :call AmendRespawn()<CR>
nnoremap <Esc>8 :call CommitRespawn()<CR>
"nnoremap <C-p> :call FZFHere()<CR>
"nnoremap <C-p> :call FZFHere()<CR>
"nnoremap <C-n> :Buffers<CR>
imap <C-b> <Left>
imap <C-f> <Right>

" save the current file as root
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" <S-F4> etc. wont work
" have to set nopaste then insert <S-F4> to get the correct sequence
silent! MapToggle <F4> foldenable
silent! MapToggle <F5> number
silent! MapToggle <F6> spell
silent! MapToggle <F7> paste
"silent! MapToggle <F8> list
"silent! MapToggle <F8> hlsearch
"silent! MapToggle <F9> wrap
map <silent> <F9> ;silent! call ToggleOpt("number") <BAR> call ToggleOpt("wrap")<CR>

"" add command to toggle diff highlighting
"if &diff
"else
    noremap <silent> <F3> :silent! call ToggleDiffSyntax() \| call DiffSyntaxStatus()<CR>
    "noremap <silent> <F3> :silent! call ToggleDiffSyntax()<CR>:call DiffSyntaxStatus()<CR>
"endif
    noremap <silent> <F2> :call ToggleKeymap()<CR>

"Sadly this interferes with vim-sneak
"Hardcode into vim?
"swap colon and semicolon
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" This fixes select-mode when needing to enter dvorak letters (e.g. in
" snipmate)
sunmap ;

"swap j with gj and k with gk
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk
nnoremap gj j
nnoremap gk k
xnoremap gj j
xnoremap gk k

"swap quote and backtick
nnoremap ' `
nnoremap ` '

vnoremap <TAB> :RetabIndent<CR>

"au FileType python au BufWritePre *.py :%s/\s+$//e
"noremap <F11> :update<CR>

nnoremap <F1> :h<BAR>only<CR>

nnoremap t% :call MaximizeToggle ()<CR>


" insert date <S-F8>
nnoremap <F8> "=strftime("%c")<CR>P
inoremap <F8> <C-R>=strftime("%c")<CR>
cnoremap <F8> <C-R>=strftime("%c")<CR>
" See fixkeymaps-vimrc

"" English definition of highlighted word
"xmap <silent> Zdd "zxi<C-R>=system('sdcv '.@z)<CR><ESC>;normal! `[v`]<CR>h
"xmap <silent> Zdd "zy;call RunInTmux('sdcv '.@z)<CR>
"nmap <silent> Zdd viw"zy;call RunInTmux('sdcv '.@z)<CR>
xmap <silent> Zdd "zy;call RunInTmuxHSplit('sdcv '.@z)<CR>
nmap <silent> Zdd viw"zy;call RunInTmuxHSplit('sdcv '.@z)<CR>

"xmap <silent> Zdd "zy;silent! call TmuxFLCached(@z)<CR>
"nmap <silent> Zdd viw"zy;silent! call TmuxFLCached(@z)<CR>

"xmap <silent> Zx "zy;call RunInTmux(@z)<CR>
"nmap <silent> Zx Y"zy;call RunInTmux(@z)<CR>
" it's just easier
" Make a function that also echos out
xmap <silent> ZK "zy;silent! call TmuxFLCached(@z)<CR>
nmap <silent> ZK viw"zy;silent! call TmuxFLCached<CR>
xmap ZL "zy;call TmuxGoogle(@z)<CR>
nmap ZL viw"zy;call TmuxGoogle(@z)<CR>

fun! TmuxGoogle(incmd)
    let cmd = 'tm -f nw '.escape(fnameescape('gr -- '.escape(fnameescape(a:incmd), "#%()")), "#%()")
    "let cmd = 'tm nw gr '.a:incmd
    call system(cmd.'&')
    "echom cmd
endf

fun! TmuxFLCached(incmd)
    let cmd = 'tmux-google-description-cached-detach.sh '.escape(fnameescape(a:incmd), "#%()")
    call system(cmd.'&')
    echom cmd
endf

"nmap w wi
"nmap b bi
"nmap e ei

" }}}

" autocommands
" {{{
if has('autocmd')
    autocmd BufWrite * if &diff | diffu | endif

    au FileType vim  set foldmethod=marker

    augroup vimrc
        au BufReadPre * setlocal foldmethod=manual
    augroup END

    autocmd BufEnter * if &filetype == "" | setlocal ft=txt | endif

    au BufWritePost * silent call ModeChange()
endif
" }}}

" after
" {{{


" plugin settings
" {{{
" Added a -f to follow symlinks. Is this OK?
let g:ackprg = 'ag -f --nogroup --nocolor --column'

" source $MYGIT/config/vim/ycm-eclim-config.vim
exe "source ".g:mygit."/config/vim/ycm-eclim-config.vim"

let g:EclimCompletionMethod = 'omnifunc'

let g:locateopen_exactly = 0
let g:ctrlp_by_filename = 0
let g:EclimLocateFileDefaultAction = 'edit'
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 1

"let g:tmuxcomplete#trigger = 'completefunc'

"this doesnt seem to have any effect
let g:use_zen_complete_tag = 1
" syntax highlighting is messed up by this
"let g:EasyMotion_do_shade = 0

let g:EasyMotion_leader_key = '<Leader><Leader>'
" <S-Tab> doesn't work in insert mode
" ∵ M-S-Tab == S-Tab == [Z
" using Q can do forward search in insert mode
"let g:EasyMotion_mapping_w = '<C-j>'
"let g:EasyMotion_mapping_b = '<C-k>'
"let g:EasyMotion_mapping_b = '<C-k>'
"nmap <C-k> <Plug>(easymotion-bd-w)
"xmap <C-k> <Plug>(easymotion-bd-w)
"nmap <C-k> <Plug>(easymotion-cc)
"xmap <C-k> <Plug>(easymotion-cc)

" " Select char
" nmap <C-k> <Plug>(easymotion-s)
" xmap <C-k> <Plug>(easymotion-s)

nmap <C-k> <Plug>(easymotion-bd-w)
xmap <C-k> <Plug>(easymotion-bd-w)

" Experimenting with creating a matrix over everything
" This will only work if there are spaces instead of emptiness because
" vim's search doesn't look at emptyness (ie. after end of line).
" Could use tmux's C-M-d and add spaces (min line width) where there is
" nothing.
"nmap <C-k> <Plug>(easymotion-vc)
"xmap <C-k> <Plug>(easymotion-vc)

let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_default_mapping = 0
let g:indent_guides_enable_on_vim_startup = 1

" syntastic
" {{{
"
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" }}}

"" ctrl-p
"" {{{
""
""let g:ctrlp_user_command = 'find -L %s -type f'
""let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
""let g:follow_symlinks = 1
""ignore hidden files and folders and binary files
"let g:ctrlp_user_command = 'find -L %s -not -path "*/\.*" -type f -exec grep -Il . {} \;'
"let g:ctrlp_max_height = 50
"
"" }}}

" vim-javascript
" {{{
let g:javascript_conceal_function   = "ƒ"
let g:javascript_conceal_null       = "ø"
let g:javascript_conceal_this       = "@"
let g:javascript_conceal_return     = "⇚"
let g:javascript_conceal_undefined  = "¿"
let g:javascript_conceal_NaN        = "ℕ"
let g:javascript_conceal_prototype  = "¶"
let g:javascript_conceal_static     = "•"
let g:javascript_conceal_super      = "Ω"
" }}}

" }}}
" }}}

" Whyyyyyy
call SetStatusLineStyle()

""" NERDCommenter
"let NERDCreateDefaultMappings=0 " disable default mappings
let NERDMenuMode=0              " disable menu
let NERDSpaceDelims=1           " place spaces after comment chars
let NERDDefaultNesting=0        " don't recomment commented lines

xmap # <Plug>NERDCommenterToggle
nmap # <Plug>NERDCommenterToggle

" Easily GREP current word in current file so results are shown in
" quickfix
command! GREP :execute 'vimgrep '.expand('<cword>').' '.expand('%') | :copen | :cc

" delete buffer without closing window
function! Bclose()
    let curbufnr = bufnr("%")
    let altbufnr = bufnr("#")
    if buflisted(altbufnr)
        buffer #
    else
        bnext
    endif
    if bufnr("%") == curbufnr
        new
    endif
    if buflisted(curbufnr)
        execute("bdelete! " . curbufnr)
    endif
endfunction

" For navigating with mouse, enter (go def) and C-o, C-i (forwards and
" backwards) efficiently
map <Esc>Rm <C-o>
map <Esc>Rt <C-i>

map <Esc>Om <C-o>
map <Esc>Ok <C-i>

command! Tlist :TagbarToggle

function! SavePos()
    silent! call system("save-cursor-position.sh ".screencol()." ".screenrow()."& disown")
endfunction

"let g:tagbar_left = 1

"au CursorMoved * silent call SavePos()

" Get line numbers by extracting from a log file using sed and pipe them
" line by line into a vim command which displays the trace order and
" highlights non-touched lines.
function! ShowTrace(logfile)
    let i = 1
    for NUM in split(system('cat '.a:logfile.' | get-trace-nums.sh '.expand('%:t')), '\n')
        exe "normal ".NUM."GA #".i
        let i = i + 1
    endfor
    g!/#\d\+$/normal 
endfunction
command! -nargs=+ ShowTrace call ShowTrace(<q-args>)

function! DuplicateBuffer()
    enew
    silent! r!cat #
    bd #
endfunction

command! DuplicateBuffer call DuplicateBuffer()

"function! ShowResults()
"    let origname = @%
"    DuplicateBuffer
"    set number
"    set ft=grep
"    set ls=0
"    silent! call ToggleBrightness()
"    silent! call ToggleBrightness()
"    silent! EraseBadWhitespace
"    silent! AnsiEscMinimiseColorize
"    if origname =~ 'cppcheck'
"        silent! %!SEDOPTS=' ' mnm | SEDOPTS=' ' colorize-cppcheck.sh
"    else
"        silent! %!SEDOPTS=' ' mnm | SEDOPTS=' ' colorize-hil-test.sh
"    endif
"    silent! AnsiEsc
"endfunction
"
"command! ShowResults call ShowResults()


iab i.. i.e.
iab g.. e.g.


" Thing is invoked when I do: C (change word to end of line) and then
" g. (to fix the spelling of a word). It's annoying.
" Get facemask for sleeping.
"iab i. i.e.
"iab g. e.g.

" Typos and incorrect spelling
iab calender calendar

iab xn Xuan

" MapNoContext (abbreviations that can check what preceded. i.e. Can
" emulate multi-word abbreviations).
" https://github.com/sunlightlabs/hacks/blob/master/topics/vim/vim-iab.md
"iab "time<space>put<space>in" "time<space>spent"

" Don't forget: headings are here
" /export/bulk/local-home/smulliga/s*/g*/c*/v*/vim/ftplugin/text.vijm

function! BufToTmux()
  cd /
  redir => vimbuf
  silent ls %
  redir END
  cd -
  silent! call system("vim-buffers-to-twin.sh", vimbuf)
  bd
  echom "Opening buffers into tmux windows."
endfunction
command! BufToTmux call BufToTmux()

nnoremap <silent> to :call BufToTmux()<CR>

function! AllBufToTmux()
  cd /
  redir => vimbufs
  silent ls
  redir END
  cd -
  silent! call system("tm vim-open-buffer-list-in-windows", vimbufs)
  echom "Opening buffers into tmux windows."
endfunction
command! AllBufToTmux call AllBufToTmux()

" don't want this to happen in visual mode
nnoremap <silent> tp :call AllBufToTmux()<CR>

let g:MRU_Use_Current_Window = 1

function! OpenShell()
  silent! let a = system("tmux-vim-open-shell.sh \"".&ft."\"")
  echom "Opening ".&ft." shell"
endfunction
command! OpenShell call OpenShell()

nnoremap <silent> tl :call OpenShell()<CR>

let g:MRU_Max_Entries = 100000

function! RandomPosition()
    let pc = system("echo -n \"$(( $RANDOM % 100 ))\"")
    exe("normal! ".pc."%")
endfunction

noremap <leader>p :!makepublic.sh %<CR>
"noremap <leader>v :silent! call system('tmux neww vimcatpub.sh "'.bufname('%').'"')<CR>
noremap <leader>v :%!vimcatpub.sh<CR>

"function! SearchForClipboard()
"    set hls
"    let nomagicquery = '\V' . substitute(@*, '\/', '\\\/', 'g')
"    silent! exe "normal! /".nomagicquery.""
"endfunction

function! SearchClipboard()
    set hls
    let @/ = '\V' . escape(@*, '\')
    normal! n
endfunction

"command! SearchForClipboard call SearchForClipboard()
nnoremap Zn :call SearchClipboard()<CR>

function! BuffersList()
  let all = range(0, bufnr('$'))
  let res = []
  for b in all
    if buflisted(b)
      call add(res, bufname(b))
    endif
  endfor
  return res
endfunction

function! GrepBuffers (expression)
  exec 'vimgrep/'.a:expression.'/ '.join(BuffersList())
endfunction

command! -nargs=+ GrepBufs call GrepBuffers(<q-args>)


" This is amazing but also a little maddening
let g:idle_time = 0
let g:typing_time = 0
let g:based = 0

" This is selled wrong but I can't do anything about it
if ! exists("g:hidecolums")
    let g:hidecolums = 0
endif

function! TmuxBaseWait()
    "silent! call system('echo "bn:'.bufname('%').' ft:'.&ft.'" >> /tmp/hithernoe')
    "" Checking filename is empty is for glossaries
    " make it only work for text files because I don't want tagbar to
    " close when viewing code. DISCARD
    " BUT I do want it to close columns when viewing code.
    " tagbar isn't very good. it's a bad plugin.  && &ft=='text'
    if g:hidecolums == 1 && g:typing_time > 0 && ! &diff && &ft != 'man' && bufname('%') != '' && bufname('%') != 'ControlP'
        " This breaks ctrlp. Find out what the buffer name is called
        " I have disabled colvim
        " vim +39 /export/bulk/local-home/smulliga/local/bin/colvim
        " This breaks lots of plugins including undotree. I can't test
        " above for it.
        only
    endif
    "if g:based == 0 && g:typing_time >= 0
    ""if g:based == 0
    "    "set nocursorline " this is not responsible for the refreshing. Neither does it break this function. It's still bad. See below
    "    "make the whole of vim redraw
    "    call system('tmux run -b tmux-base-here.sh')
    "    let g:based = 1
    "    " I wish this wasn't necessary, but it is because vim sucks at
    "    " async commands.
    "    normal! 
    "    exec "normal! \<C-l>"
    "endif
    let g:typing_time = g:typing_time + 1
    let g:idle_time = 0
    "echom 'based: '.g:based.' typing time: '.g:typing_time.' idle time: '.g:idle_time
endfunction

function! TmuxUnbase()
    if g:based == 1
        " try to work out the bugs
        call system('tmux run -b tmux-base-localhost.sh')
        let g:based = 0
        " I wish this wasn't necessary, but it is because vim sucks at
        " async commands.
        "normal! 
        "    exec "normal! \<C-l>"
    endif
    let g:typing_time = 0
    "echom 'based: '.g:based.' typing time: '.g:typing_time.' idle time: '.g:idle_time
    "windo set cursorline " Can't do this because it sometimes changes
    "which window you are in
endfunction

fun! ShowEnv()
    " list abbreviations
    abbreviate  
    " argument list
    args        
    " augroups
    augroup     
    " list auto-commands
    autocmd     
    " list buffers
    buffers     
    " list current breakpoints
    breaklist   
    " list command mode abbreviations
    cabbrev     
    " changes
    changes     
    " list command mode maps
    cmap        
    " list commands
    command     
    " list compiler scripts
    compiler    
    " digraphs
    digraphs    
    " print filename, cursor position and status (like Ctrl-G)
    file        
    " on/off settings for filetype detect/plugins/indent
    filetype    
    " list user-defined functions (names and argument lists but not the full code)
    function    
    " user-defined function Foo() (full code list)
    function Foo
    " highlight groups
    highlight   
    " command history
    history c   
    " expression history
    history =   
    " search history
    history s   
    " your commands
    history     
    " list insert mode abbreviations
    iabbrev     
    " list insert mode maps
    imap        
    " the Vim splash screen, with summary version info
    intro       
    " your movements
    jumps       
    " current language settings
    language    
    " all variables
    let         
    " variable FooBar
    let FooBar  
    " global variables
    let g:      
    " Vim variables
    let v:      
    " buffer lines (many similar commands)
    list        
    " language mappings (set by keymap or by lmap)
    lmap        
    " buffers
    ls          
    " buffers, including "unlisted" buffers
    ls!         
    " Insert and Command-line mode maps (imap, cmap)
    map!        
    " Normal and Visual mode maps (nmap, vmap, xmap, smap, omap)
    map         
    " buffer local Normal and Visual mode maps
    map<buffer> 
    " buffer local Insert and Command-line mode maps
    map!<buffer>
    " marks
    marks       
    " menu items
    menu        
    " message history
    messages    
    " Normal-mode mappings only
    nmap        
    " Operator-pending mode mappings only
    omap        
    " display buffer lines (useful after :g or with a range)
    print       
    " registers
    reg         
    " all scripts sourced so far
    scriptnames 
    " all options, including defaults
    set all     
    " global option values
    setglobal   
    " local option values
    setlocal    
    " options with non-default value
    set         
    " list terminal codes and terminal keys
    set termcap 
    " Select-mode mappings only
    smap        
    " spellfiles used
    spellinfo   
    " syntax items
    syntax      
    " current syntax sync mode
    syn sync    
    " tab pages
    tabs        
    " tag stack contents
    tags        
    " leaves of the undo tree
    undolist    
    " show info about where a map or autocmd or function is defined
    verbose     
    " list version and build options
    version     
    " Visual and Select mode mappings only
    vmap        
    " Vim window position (gui)
    winpos      
    " visual mode maps only
    xmap        
endf
command! ShowEnv Message call ShowEnv()

"au CursorMoved * echom 'hi'.g:based
"au CursorMovedI * echom 'hi'.g:based
"au CursorHold * echom 'hi'.g:based
"au CursorHoldI * echom 'hi'.g:based

" Had to disable this because it broke ctrlp. But the functionality
" for closing extra columns is more important.
augroup auto_tmux_collapse
  au!
  au CursorMoved * silent! call TmuxBaseWait()
  "au CursorMovedI * silent! call TmuxBaseWait()
  "au CursorHold * silent! call TmuxUnbase()
  "au CursorHoldI * silent! call TmuxUnbase()

  "au CursorMoved * call TmuxBaseWait()
  "au CursorMovedI * call TmuxBaseWait()
  "au CursorHold * call TmuxUnbase()
  "au CursorHoldI * call TmuxUnbase()
  "au InsertEnter * call TmuxBaseWait()
  "au InsertLeave * call TmuxUnbase()
  "au FocusGained * call TmuxBaseWait()
  "au FocusLost * call TmuxUnbase()
augroup END

" TextChangedI
" InsertEnter

function! ForceQuit()
    "silent! call TmuxUnbase()
    qa!
endfunction

command! ForceQuit silent! call ForceQuit()


"" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"" If you want :UltiSmagit-blame.shnipsEdit to split your window.
""let g:UltiSnipsEditSplit="vertical"

"let g:snips_trigger_key = '<c-e>'
"let g:snips_trigger_key_backwards = '<c-z>'

function! IncrementSearchString()
    if ! empty(@/)
        let @/ = system("php $VAS/local/bin/increment-numeric-part.php", @/)
    endif
endfunction
" <M-n>
" I need this to go up until the next successful match
" Find next highest value
"map <Esc>= ;call IncrementSearchString()<CR>n100zH

function! DecrementSearchString()
    if ! empty(@/)
        let @/ = system("php $VAS/local/bin/decrement-numeric-part.php", @/)
    endif
endfunction
"map <Esc>- ;call DecrementSearchString()<CR>N100zH

fun! CharAtCursor()
    return matchstr(getline('.'), '\%' . col('.') . 'c.')
endf

fun! ReselectVisual()
    normal! mxgv`x
endf

" Search next / previous thing which is different for this column

" I can improve on these to be more picky
fun! SearchUpDiffColPicky()
    let charatcursor = escape(CharAtCursor(), "*./\\")
    if empty(charatcursor)
        let charatcursor = ' '
    endif
    "exe '?\%'.virtcol('.').'v'.charatcursor.'\@!'
    silent! exe '?\%'.virtcol('.').'v'.charatcursor.'\@!'
endf

fun! SearchDownDiffColPicky()
    let charatcursor = escape(CharAtCursor(), "*./\\")
    if empty(charatcursor)
        let charatcursor = ' '
    endif
    "exe '/\%'.virtcol('.').'v'.charatcursor.'\@!'
    silent! exe '/\%'.virtcol('.').'v'.charatcursor.'\@!'
endf

fun! SearchUpDiffCol()
    let charatcursor = escape(CharAtCursor(), "*./\\")
    if empty(charatcursor)
        let charatcursor = ' '
    endif
    "exe '?\%'.virtcol('.').'v'.charatcursor.'\@!'
    silent! exe '?\C\%'.virtcol('.').'v\('.charatcursor.'\| \|$\)\@!'
endf

fun! SearchDownDiffCol()
    let charatcursor = escape(CharAtCursor(), "*./\\")
    if empty(charatcursor)
        let charatcursor = ' '
    endif
    "exe '/\%'.virtcol('.').'v'.charatcursor.'\@!'
    silent! exe '/\C\%'.virtcol('.').'v\('.charatcursor.'\| \|$\)\@!'
endf

"nnoremap <Esc>_ :exe '?\%'.virtcol('.').'v'.matchstr(getline('.'), '\%' . col('.') . 'c.').'\@!'<CR>
"nnoremap <Esc>+ :exe '/\%'.virtcol('.').'v'.matchstr(getline('.'), '\%' . col('.') . 'c.').'\@!'<CR>
nnoremap <Esc>_ :call SearchUpDiffCol()<CR>
nnoremap <Esc>+ :call SearchDownDiffCol()<CR>
"xnoremap <Esc>_ <C-c>:exe '?\%'.virtcol('.').'v'.matchstr(getline('.'), '\%' . col('.') . 'c.').'\@!'<CR>mxgv`x
"xnoremap <Esc>+ <C-c>:exe '/\%'.virtcol('.').'v'.matchstr(getline('.'), '\%' . col('.') . 'c.').'\@!'<CR>mxgv`x
xnoremap <Esc>_ <C-c>:call SearchUpDiffCol() \| call ReselectVisual()<CR>
xnoremap <Esc>+ <C-c>:call SearchDownDiffCol() \| call ReselectVisual()<CR>

"nnoremap <Esc>- :exe '?\%'.virtcol('.').'v'.matchstr(getline('.'), '\%' . col('.') . 'c.').'\@!'<CR>
"nnoremap <Esc>= :exe '/\%'.virtcol('.').'v'.matchstr(getline('.'), '\%' . col('.') . 'c.').'\@!'<CR>
nnoremap <Esc>- :call SearchUpDiffColPicky()<CR>
nnoremap <Esc>= :call SearchDownDiffColPicky()<CR>
"xnoremap <Esc>- <C-c>:exe '?\%'.virtcol('.').'v'.matchstr(getline('.'), '\%' . col('.') . 'c.').'\@!'<CR>mxgv`x
"xnoremap <Esc>= <C-c>:exe '/\%'.virtcol('.').'v'.matchstr(getline('.'), '\%' . col('.') . 'c.').'\@!'<CR>mxgv`x
xnoremap <Esc>- <C-c>:call SearchUpDiffColPicky() \| call ReselectVisual()<CR>
xnoremap <Esc>= <C-c>:call SearchDownDiffColPicky() \| call ReselectVisual()<CR>

" M-n and M-N work very similarly to n and N, but they change the
" increment. It's perfect

"let g:tmuxsession = system('get-tmux-from-pid.sh '.getpid()." | awk '{print $2}' | tr -d '\n'")
" this is a lot faster but not necessary.
let g:tmuxsession = system("tmux display-message -p -t $TMUX_PANE '#{session_name}' | tr -d '\n'")
"Instead of always getting the session from TMUX_PANE, only actually
"ask tmux for it when you need it?
" it will help a little bit, not much, in times of great lag.

let g:rainbow_active = 1

"inoreab hilite highlight
"inoreab hilight highlight
"inoremap U <Esc>vUa
"inoremap I <Esc>vbUea
"inoremap C <Esc>vbuvUea
"inoremap L <Esc>bveuea
"inoremap T <Esc>bbvUea
"inoremap R <Esc>bbbvUea
"imap K <Esc>0<c-k>
""inoremap C <C-o>`[<Right><Esc>vUea
"inoremap : <Esc>0/\a<CR>0NnvUA
"inoremap P <Esc>F<Space>xA
"inoremap D <Esc>^i<Tab><Esc>A
"" make it so this is undoable.
"inoremap F <Esc>:set spell<CR>[s1z=:set nospell<CR>A

function! MyCoolFunction(anArg)
python << endpython
import vim
anArg = vim.eval("a:anArg")
# do important stuff
vim.command("return 1") # return from the Vim function!
endpython
endfunction

filetype plugin on

" make functions to run 'normal' commands in paste mode (or even
" better, with an option enabled)
fun! OpenLineUp()
    set paste
    normal! O
    set nopaste
endf
fun! OpenLineDown()
    set paste
    normal! o
    set nopaste
endf

nnoremap Y ^vg_o

nnoremap z= :set spellz=

let g:vim_json_syntax_conceal = 0

"nnoremap gm :silent! call system('automate-magit.sh "'.expand('%:p').'" '.line('.'))<CR>
nnoremap gm :silent! call system('show-git-line-history.sh "'.expand('%:p').'" '.line('.'))<CR>

"autosave
" {{{
"let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save = 0  " AutoSave disabled -- problems -- slight delays.

" AutoSave relies on CursorHold event and sets the updatetime option to 200 so that modifications are saved almost instantly.
" But sometimes changing the updatetime option may affect other plugins and break things.
" You can prevent AutoSave from changing the updatetime with g:auto_save_no_updatetime option:

" .vimrc
let g:auto_save_no_updatetime = 1  " do not change the 'updatetime' option

" You can disable AutoSave in insert mode with the g:auto_save_in_insert_mode option:

" .vimrc
"let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

" AutoSave will display on the status line on each auto-save by default.

" You can silence the display with the g:auto_save_silent option:

" .vimrc
let g:auto_save_silent = 1  " do not display the auto-save notification

" If you need an autosave hook (such as generating tags post-save) then use g:auto_save_postsave_hook option:

" .vimrc
"let g:auto_save_postsave_hook = 'TagsGenerate'  " this will run :TagsGenerate after each save
" }}}

" Consider making this for ZX AND ge/gf
command! -range OpenAllRange <line1>,<line2>call OpenAllRange()
fun! OpenAllRange() range
    "echo "firstline "." lastline ".a:lastline
    exe a:firstline.",".a:lastline."g/^/exe 'badd '.getline('.')"
endfun

" TODO Make a new binding for this that uses registers to allow you to
" replace without removing the empty space at the beginning
" nmap <leader>q ;silent! s/^\s\+/<CR>Y;!q -ftln<CR>
" nmap <leader>Q ;silent! s/^\s\+/<CR>Y;!uq -ftln<CR>

nmap <leader>q ;.!q -ftln<CR>
nmap <leader>Q ;.!uq -ftln<CR>
xmap <leader>q ;!q -ftln<CR>
xmap <leader>Q ;!uq -ftln<CR>

nmap <leader>z ;silent! s/^\s\+/<CR>Y;!shell-escape.sh<CR>$XX^
nmap <leader>Z ;silent! s/^\s\+/<CR>Y;!unshell-escape.sh.pl<CR>
xmap <leader>z <ESC>\z
xmap <leader>Z <ESC>\Z

"nmap <silent> <Leader>d Y"zy;call VisCroogle(@z)<CR>
xmap <silent> <Leader>d "zy;call VisCroogle(@z)<CR>
nmap <silent> <Leader>d ;call VisCroogle(expand('<cword>'))<CR>
"xmap <silent> <Leader>d ;call VisCroogle(expand('<cword>'))<CR>
function! VisCroogle(para)
    silent! call system('tmux-tput-search.sh '.escape(shellescape(a:para.'&'),"\""))
endfunction


fun! Savethisdoc()
    :call system('cat >> /tmp/testing.txt', expand('%:p').\"\n\") 
endf

fun! Makedoc()
    let @k=""
    let @j="@klyc;w!  >>/tmp/testing.txtccl"
endf

fun! HighlightCurrentLine()
    normal 
endf

fun! DiffOpts()
    " I have disabled syntax highlighting already by deleting syntax
    " files, so this ensures I can still use snippets
    "windo set ft=
    normal Ww]c
    silent! call ToggleCommentSyntax()
    silent! windo set foldmethod=diff foldlevel=0 foldenable nolist
    silent! call ToggleDiffSyntax()
    "windo silent! call DiffWordSyntax()
    windo set colorcolumn=0
    hi CursorLine ctermfg=249 ctermbg=235
endf

fun! RunLine()
    exec '!'.getline('.')
endf

" Don't do this:
" cnoreabbrev au Message au
" " doing this for 'set' causes * to stop working
" "cnoreabbrev set Message set
" cnoreabbrev reg Message reg
" cnoreabbrev map Message map
" cnoreabbrev cmap Message cmap
" cnoreabbrev nmap Message nmap
" cnoreabbrev xmap Message xmap
" cnoreabbrev vmap Message vmap
" cnoreabbrev smap Message smap
" cnoreabbrev imap Message imap
" cnoreabbrev mess Message mess
" Instead, use alias commands:
cnoreabbrev mau Message au
cnoreabbrev mset Message set
cnoreabbrev mreg Message reg
cnoreabbrev mmap Message map
cnoreabbrev mcmap Message cmap
cnoreabbrev mnmap Message nmap
cnoreabbrev mxmap Message xmap
cnoreabbrev mvmap Message vmap
cnoreabbrev msmap Message smap
cnoreabbrev mimap Message imap
cnoreabbrev mmess Message mess

abbrev dnt doesn't
abbrev dtn doesn't

abbrev impack impact
abbrev Impack Impact

fun! MinimiseAndWrap()
    " What about these?
    "     let x=line(".")
    "     map !s :! spec % <C-r>=line('.')<CR><CR>
    " 
    " gr vimscript current line external script

    .!mnm
    normal! Vgq
endf

fun! FilterLine()
    .!bash -c "crc32 <(cat)"
endf

cmap <Esc>f <C-e><C-u>mess<CR>
cmap <Esc>d <Esc>dd
" making cmaps with an actual escape character doesn't always work. It
" also makes vim go freaky sometimes
"cmap t ge
" This appears to not work all the teime withoun a normal too
"cmap <Esc>t <Esc>ge
" <M-Tab> = <Insert>
" nmap [2~ <Insert>
imap <Esc>[2~ <Esc>ZX
nmap <Esc>[2~ ZX
cmap <Esc>t normal ge<CR>
cmap <Esc>e silent! e!<CR>
" In the future, this should bring up more useful stuff.
" a tmux split pane that I have full control over -- written myself.
cmap <Esc>p normal <leader>tb<CR>
cmap <Esc>q silent! q!<CR>
cmap <Esc>s silent! wqa!<CR>
cmap <Esc>x silent! bd!<CR>
cmap <Esc>r silent! wa! \| e!<CR>
"cmap <Esc>g call MinimiseAndWrap()<CR>
cmap <Esc>g .!mnm<CR>

" Cannot do this. Nothing can come after AsyncSave.
" I think this is what's causing the random amendments anyway.
"cmap <Esc>c silent! call AsyncSave() \| call AmendRespawn()<CR>

" Don't forget to make more of these number mappings!
" make some for googling
cmap <silent> <Esc>7 silent! call AmendRespawn()<CR>

command! K call ToggleKeymap() " This is the one I should use
command! TK call ToggleKeymap()
" cmap <Esc>v call ToggleKeymap()<CR>

cmap <silent> <Esc>8 silent! call CommitRespawn()<CR>
cmap <silent> <Esc>9 Git difftool HEAD\^\! -- %<CR><C-L>
cmap <silent> <Esc>1 <Esc>Y"zy;call RunInTmuxNoQuit(@z)<CR>
cmap <silent> <Esc>2 normal! gg0<CR>
cmap <silent> <Esc>4 call FilterLine()<CR>
" Useful but not ideal
cmap <silent> <Esc>0 <C-f>0iMessage <C-c><CR>
nmap <silent> ZJ Y"zy;call RunInTmuxNoQuit(@z)<CR>
xmap <silent> ZJ "zy;call RunInTmuxNoQuit(@z)<CR>
"cmap <left> <C-f><C-w>_<left>
" can't do this because i use it to put the last command on the line
"cmap <up> <C-f><C-w>_0i

" This was the bane of my life
" cmap <down> <C-f><C-w>_A

" disable these because they don't feel natural
" cmap <left> <C-f><C-w>_0i
" cmap <right> <C-f><C-w>_<right>

" snipmate menu selection mode?
" no, select mode is like visual mode.
" there is no such thing as menu mode
"smap u <Esc>dd

nnoremap <leader>ri :RetabIndent<CR>

" for starting a new snippet complete from within a snippet
" i'm not sure how to break out of select mode without using a motion
" smap means it must be selected
smap <Esc>L <Esc>a<Esc>ljki<C-l>
" snipmate global variables might be bringing me back into select mode
" but nothing to fear, this takes care of it
imap <Esc>L <Esc>a<Esc>ljki<C-l>
" Swapping C-l with <Esc>L only makes it worse

" Hacky solution to dvorak issue inside select mode
smap : <C-h>S

" fun! CRSelect()
    " let cliptemp=@"
    " exe expand("normal \<C-h>\<C-r>")
    " let @"=cliptemp
" endf

fun! SelectCR()
    exe expand("normal! GA\<CR>\<CR>\<Esc>0")
    startinsert
    <Esc>h;let cliptemp=@*<CR>i<C-l>
endf

" Access registers from select mode
smap <C-r> <C-h><C-r>

"smap <C-r> <C-h><c-o>;let @*=Chomp(@0)<CR><C-r>
"smap <C-r> <Esc>a;let cliptemp=@*<CR><C-l><C-h><c-r>
" smap <C-r> <Esc>h;let cliptemp=@*<CR>i<C-l>
"snoremap <C-r> :call CRSelect()<CR>

snoremap <C-h> h<C-h>
snoremap <C-w> h<C-w>

" how select mode works
"" the idea with this is that you use # to select a word and then . to
"" insert the contents of the @. register
"nnoremap # *``gn<C-g>
"inoremap # <C-o>gn<C-g>
"snoremap <expr> . @.

fun! CopyQuotedNextLine()
    silent! call system("sed 's/^\\s\\+//' | q | xc", getline(line('.') + 1))
    echom "Quoted and copied the next line"
endf

fun! CopyQuotedCurrentLine()
    silent! call system("sed 's/^\\s\\+//' | q | xc", getline(line('.')))
    echom "Quoted and copied current line"
endf

command! CopyQuotedNextLine call CopyQuotedNextLine()
command! CopyQuotedCurrentLine call CopyQuotedCurrentLine()

fun! OpenFileInTmux(fn)
    " Open can take stdin as the filename
    " The open command starts its own tmux windows. But it shouldn't.
    " Remain consistent.
    " silent! call system("tm -tout -S nw open", a:fn)
    " silent! call system("open", a:fn)

    " silent! call system("unbuffer ge -h -e \"".a:fn."\"")
    " silent! call system("tm open-list-of-files-in-windows", fn)
    " call system("a beep", a:fn)
    " call system("pwd | tv", a:fn)

    " Sometimes the CWD is incorrect but the actual wd is correct
    call system("CWD= tm open-list-of-files-in-windows", a:fn)
endf

fun! GoWhich(fn)
    silent! call system("tm -f -tout -S sph open", a:fn)
endf

noremap <silent> ge :<C-U>call OpenFileInTmux(expand("<cfile>"))<cr>
xnoremap <silent> ge "zy:<C-U>call OpenFileInTmux("<C-R>z")<cr>

noremap gw :<C-U>call GoWhich(expand("<cfile>"))<cr>
xnoremap gw "zy:<C-U>call GoWhich("<C-R>z")<cr>

"noremap ge :<C-U>call gf_ext#GoFileTmux(expand("<cfile>"))<cr>
"xnoremap ge "zy:<C-U>call gf_ext#GoFileTmux("<C-R>z")<cr>

function! TmuxRunSync(cmd,stdin)
    call system('tm -f -tout nw -icmd', escape(shellescape(a:cmd),'"'))
endfunction

function! TmuxRunAsync(cmd)
    call system('tmux-run.sh '.escape(shellescape(a:cmd),'"'), a:stdin)
endfunction

"map T GA<CR><CR><Esc>0i
"map TT gg0i<CR><CR><Esc>ggi
" map TTT GA<CR><CR><Esc>0i

" These make dd a little better with <Esc>
nnoremap <Esc>d<Esc>d dd
nnoremap d<Esc>d dd


exe "source ".g:mygit."/config/vim/loadsave-quickfix.vim"

fun! SearchForPat(pat, fn)
    exe "!echo \"".expand("%")."\" >> ".a:fn
    exe "!echo \"".a:pat."\" >> ".a:fn
    " vimgrep a:pat %
    exe "vimgrep ".a:pat." %"
    call SaveQuickFixList(a:fn)
endf

" nmap <silent> to viw"xy;silent! call GoogleFixWord(@x)<CR>
" xmap <silent> to "xy;silent! call GoogleFixWord(@x)<CR>
function! GoogleFixWord(para)
    " Can't use @z because viw is bound to something that overwrites z
    let @x = system('c google-spell-check.sh '.escape(shellescape(a:para),"\"")." 2>/dev/null")[:-2]
    if ! empty(@x)
        normal! viw"xp
    endif
endfunction

" nmap <silent> to viw"xy;silent! call GoogleFixWord(@x)<CR>
" xmap <silent> to "xy;silent! call GoogleFixWord(@x)<CR>
" function! GoogleFixWord(para)
    " Can't use @z because viw is bound to something that overwrites z
    " let @x = system('c google-spell-check.sh '.escape(shellescape(a:para),"\"")." 2>/dev/null")[:-2]
    " if ! empty(@x)
        " normal! viw"xp
    " endif
" endfunction


fun! OpenInBestEditor()
    call system('edit-code.sh "'.expand('%:p').'" '.line('.') . ' ' . (col('.')))
endf

nnoremap tb :call OpenInBestEditor()<CR>
nnoremap t<Esc>b :call OpenInBestEditor()<CR>

fun! OpenInVi()
    call system('vim-open-in-vi.sh "'.expand('%:p').'" '.line('.') . ' ' . (col('.')))
endf

fun! OpenInEditor(ed)
    " This is to make sure we have a buffer to open in emacs
    call SaveTemp()
    " But I don't want to change the clipboard
    call system('vim-open-in.sh -e '.a:ed.' "'.expand('%:p').'" '.line('.') . ' ' . (col('.')))
endf

fun! OpenInEmacs()
    " Don't use the if statement. I want to save the file so I keep the
    " cursor position.

    " if filereadable(expand('%')))
        " This is to make sure we have a buffer to open in emacs
        "normal yp
        call SaveTemp()
        " But I don't want to change the clipboard

        " call Xc('tm -f -te -d spv -args e -a c +'.line('.').':'.col('.').' '.Q(expand('%:p')))
        call system('tm -f -tout -d spv -args e -a c +'.line('.').':'.(col('.') - 1).' '.Q(expand('%:p')))
    " else
        " call TvEmacs(GetBufferContents())
    " endif
endf

fun! OpenInYi()
    call SaveTemp()

    call system('tm -f -tout nw -icmd', 'yi -l '.line('.').' -c '.col('.').' "'.expand('%:p').'"')
endf

fun! Bind1WithFzf()
    call SaveTemp()
    call system("tm -f -t nw -noerror \"f bind1-with-fzf ".expand('%:p')."\" &")
endf

fun! OpenInRifle()
    call SaveTemp()
    call system("tm -f -t nw -noerror \"rifle ".expand('%:p')."\" &")
endf

fun! OpenInEmacsColour()
    " This is to make sure we have a buffer to open in emacs
    "normal yp
    call SaveTemp()
    " But I don't want to change the clipboard
    call system('vim-open-in-emacs.sh -c "'.expand('%:p').'" '.line('.') . ' ' . (col('.')))
endf

" Use OpenInMagit instead
fun! OpenInMagitFile()
    call system("tm -d nw -fa magit-x ".Q(expand('%:p')))
endf

nnoremap tm :call OpenInEmacs()<CR>
nnoremap t<Esc>m :call OpenInEmacs()<CR>

fun! OpenInNano()
    call system('vim-open-in-nano.sh "'.expand('%:p').'" '.line('.') . ' ' . (col('.')))
endf

nnoremap tn :call OpenInNano()<CR>
nnoremap t<Esc>n :call OpenInNano()<CR>

fun! OpenInMagit()
    call system('tm -d sph -fa magit '.Q(expand('%:p')))
endf

nnoremap <Esc>m :call OpenInMagit()<CR>
" nnoremap <Esc>m :call OpenInEmacs()<CR>

imap <C-d> <Delete>
cmap <C-d> <Delete>

map <Esc>< gg0
map <Esc>> G$

fun! GetBufferContents()
    return join(getline(1, '$'), "\n")
endf

fun! FZFpreview()
    call system("tmux-pipe-command.sh fzf", GetBufferContents())
endf

fun! RTGrepFilesInHere()
    call system("tmux-rt-grep-files-in-here.sh -d", GetBufferContents())
endf

fun! EmacsOccurFileContents()
    call system("tmux-open-list-of-files-in-emacs.sh -d", GetBufferContents())
endf

fun! OpenInPVD()
    call SaveTemp()
    call system("tnw -n ".Q(expand('%'))." "."fpvd ".Q(expand('%:p'))." &>/dev/null &")
endf

fun! WordFrequenciesPVD()
    call SaveTemp()
    "call system("tnw.sh \"".expand('%')."\" \"show-word-frequencies-fpvd.sh \\\"".expand('%:p')."\\\"\" &>/dev/null &")
    "call system("tmux-split-here.sh \"show-word-frequencies-fpvd.sh \\\"".expand('%:p')."\\\"\" &>/dev/null &")
    call system("tspbg.sh -p 30 -o -h \"show-word-frequencies-fpvd.sh \\\"".expand('%:p')."\\\"\" &>/dev/null &")
endf

fun! CheckCode()
    call SaveTemp()
    "call system("tspbg.sh -p 30 -o -h \"check-code.sh \\\"".expand('%:p')."\\\"\" &>/dev/null &")
    call system("tspbg.sh -D -p 50 -o -h \"check-code.sh \\\"".expand('%:p')."\\\"\" &>/dev/null &")
endf

fun! CheckIssue()
    call SaveTemp()
    call system("tspbg.sh -D -p 50 -o -h \"check-issue.sh\" &>/dev/null &")
endf

fun! TestCode()
    call SaveTemp()
    call system("tspbg.sh -D -p 50 -o -h \"test-code.sh\" &>/dev/null &")
endf

fun! OpenSnippets()
    "call system('tm -f nw "e $VIMSNIPS/'.&filetype.'.snippets" &')
    "call system('tm -f nw "vim '.fp.'" &')
    "call system('tnw.sh snippets "e '.fp.'" &')
    "
    let fp = '$VIMSNIPPETS/'.&filetype.'.snippets'
    "call system('tm -f -te -d spv -pak -n snippets "open -e '.fp.'" &')
    
    call system('tm -f -te -d spv -n snippets "vs '.fp.'" &')
endf

fun! DocumentationForThis()
    call system('tspbg.sh -o "" -h -p 60 "pydoc-file \"'.expand('%:p').'\"" &')
endf

fun! ScopeThisFile()
    call system('tm -f nw "scope.sh \"'.expand('%:p').'\" | vim -" &')
endf

fun! ScopeCursor()
    call system('tm -f nw "scope.sh \"'.getline(line('.')).'\" | ecn" &')
endf

let g:go_def_mapping_enabled = 0

" Can't map C-c after C-x
" C-x uses speed-dating. so can't do this.
" need another fast, ergonomic method of quitting vim
"map <C-x><C-c> <Esc>ZQ
"map <C-x>c <Esc>ZQ
"nnoremap <C-x><C-c> <Esc>:qa!
"nnoremap <C-x> <Esc>:qa!
"nnoremap <C-x> <Esc>:qa!
"cnoremap <C-c> <CR>

" Thank goodness for this
map <F1> <Nop>

fun! InsertAtTop()
    " Need the escapes
    exe expand("normal! gg0i\<CR>\<CR>\<Esc>gg")
    " normal command always ends in normal mode
    startinsert
endf

fun! InsertAtBottom()
    " Need the escapes
    exe expand("normal! GA\<CR>\<CR>\<Esc>0")
    " normal command always ends in normal mode
    startinsert
endf

fun! InsertAtBottomPaste()
    " Need the escapes
    exe expand("normal! GA\<CR>\<CR>\<Esc>0P")
    " normal command always ends in normal mode
    startinsert
endf

"map T GA<CR><CR><Esc>0i

"fun

fun! InsertParaAbove()
    "exe expand("normal! 0O\<Esc>O")
    exe expand("normal! 0O\<Esc>O")
    startinsert
endf

fun! JumpAndInsert()
    call EasyMotion#CC(0,2)
    " xmap
    "call EasyMotion#CC(0,2)
    startinsert
endf

"map T GA<CR><CR><Esc>0i
"map TT gg0i<CR><CR><Esc>ggi
"" map TTT GA<CR><CR><Esc>0i

fun! TmuxLinks()
    call RunInTmux("note getlinks | fzf --sort --sync | xc")
endf


"fun! OpenInVim()
"    call system("tmux-vim.sh ".expand('%:p')." &")
"endf

fun! OpenInVanillaVim()
    call system("tnw -xargs vi ".expand('%:p')." &")
endf

fun! OpenIPython()
    call system("tnw -c \"".expand("%:p:h")."\" -n ipython3 ipython3 1>/dev/null 2>/dev/null &")
endf

fun! OpenBPython()
    call system("tnw -c \"".expand("%:p:h")."\" -n bpython3 bpython3 1>/dev/null 2>/dev/null &")
endf

fun! OpenPTPython()
    call system("tnw -c \"".expand("%:p:h")."\" -n ptpython ptpython 1>/dev/null 2>/dev/null &")
endf

fun! OpenInPDB()
    " this can automatically detect the version of python
    call system("tnw -c \"".expand("%:p:h")."\" -n pdb \"BP=".line(".")." pdb -i \\\"".expand("%:p")."\\\"; pak\" 1>/dev/null 2>/dev/null &")
endf

fun! OpenInPTPDB()
    " this can automatically detect the version of python
    call system("tnw -c \"".expand("%:p:h")."\" -n ptpdb \"BP=".line(".")." ptpdb -i \\\"".expand("%:p")."\\\"; pak\" 1>/dev/null 2>/dev/null &")
endf

fun! TmuxPydoc(arg)
    call system("tnw -n pydoc \"pydoc ".a:arg."\" 1>/dev/null 2>/dev/null &")
endf
command! -nargs=+ TmuxPydoc call TmuxPydoc(<f-args>)

fun! OpenInScimax()
    " This is to make sure we have a buffer to open in emacs
    "normal yp
    call SaveTemp()
    " But I don't want to change the clipboard
    call system('tnw sc "'.expand('%:p').'" '.line('.') . ' ' . (col('.')))
endf

fun! OpenRangerHere()
    call system("tm -f r \"".expand("%:p:h")."\"")
endf

fun! OpenCtagsForThis()
    call system('tnw "( ctags-hr \"'.expand('%:p').'\"; echo; pydoc \"'.expand('%:p').'\" ) | sp" &>/dev/null &')
endf

fun! OpenSourceInfo()
    call Sys('tnw eval '.Q('ct describe-file '.Q(expand('%:p')).' | sp') &>/dev/null &')
endf

fun! MQQuit()
    wqa!
endf

"fun! MapMG(key, func)
"    exec 'nnoremap <Esc>g<Esc>'.a:key.' :call '.a:func.'()<CR>'
"    exec 'inoremap <Esc>g<Esc>'.a:key.' <Esc>:call '.a:func.'()<CR>'
"    exec 'xnoremap <Esc>g<Esc>'.a:key.' <Esc>:call '.a:func.'()<CR>'
"endf
"command! -nargs=+ MapMG call MapMG(<f-args>)
"
"fun! MapMQ(key, func)
"    exec 'nnoremap <Esc>q<Esc>'.a:key.' :call '.a:func.'()<CR>'
"    exec 'inoremap <Esc>q<Esc>'.a:key.' <Esc>:call '.a:func.'()<CR>'
"    exec 'xnoremap <Esc>q<Esc>'.a:key.' <Esc>:call '.a:func.'()<CR>'
"endf
"command! -nargs=+ MapMQ call MapMQ(<f-args>)

nnoremap <C-e> :call MovePercent(-5, 'n')<CR>
nnoremap <C-t> :call MovePercent(5, 'n')<CR>

xnoremap <C-e> :call MovePercent(-5, 'v')<CR>
xnoremap <C-t> :call MovePercent(5, 'v')<CR>

nnoremap <C-n> :call MovePercent(-10, 'n')<CR>
nnoremap <C-p> :call MovePercent(10, 'n')<CR>

xnoremap <C-n> :call MovePercent(-10, 'v')<CR>
xnoremap <C-p> :call MovePercent(10, 'v')<CR>


fun! EscDollar()
    " This works on the current line
    s/\$/\\\$/g
endf

fun! GoToTop()
    exe expand("normal! \<Esc>gg")
endf

fun! SubstituteSelection()
    let @x = system('(tsk "Y";tsk ";s/"; tsk "C-r"; tsk "\\*") &')[:-2]
    if v:shell_error == 0
        echom "success"
    endif
endf

fun! WrapParagraph()
    exe expand("normal! vipgq")
endf

function! EraseBadWhitespace()
    EraseBadWhitespace
endfunction

fun! RenameExtension()
    let @x = system("tmux send-keys ';Rename %' Tab 'C-w' &")[:-2]
    "if v:shell_error == 0
    "    echom "success"
    "endif
endf

fun! SelectType()
    silent! call system("tmux send-keys ';set ft=' &")
    silent! call SelectFileType()
    silent! call system("tmux send-keys Enter &")
endf

fun! SelectRefactoring()
    silent! call system("tmux send-keys ';%!' &")
    silent! call SelectRefactoringUsingFZF()
    silent! call system("tmux send-keys Enter &")
endf

fun! RemoveFactGlobally()
    call FilterBufferWithCommand("fzf-remove-fact")
endf

fun! SelectFilter()
    silent! call system("tmux send-keys ';%!' &")
    silent! call SelectFilterUsingFZF()
    silent! call system("tmux send-keys Enter &")
endf

fun! Anywhere_gf()
    silent! normal! gf
endf

fun! CopyLineAndRunInTmux()
    " normal! Y"zy
    " call RunInTmux(@z)

    let line_contents = getline(".")
    call Xc(line_contents)
    call RunInTmux(line_contents)
endf

"" This should be obvious.. see the actual mapping
"fun! StartTabularize(mode)
"    "normal! :Tabular
"    normal! :
"endf
"
""function StartTabularize(mode)
""    normal! :Tabularize /
""
""    if a:mode ==# 'v'
""        normal! gv
""    endif
""endfunction
"
"nnoremap <Esc>q<Esc>a :call StartTabularize('n')<CR>
"xnoremap <Esc>q<Esc>a :<C-u>call StartTabularize('v')<CR>
"
xnoremap <Esc>q<Esc>a :Tabularize /

fun! Lines()
    " fzf
    Lines
endf

" I use this all the time.
MapM InsertParaAbove q o
" MapM OpenInEmacs q o
MapM CommitRespawn q 8
MapM AmendRespawn q 7
MapM RT q l
MapM JumpAndInsert q k
MapM JumpAndInsert g k
MapM OpenInVi t k
MapM OpenInScimax q s
MapM OpenInScimax t s
MapM OpenInScimax t j
MapM OpenIPython q i i
MapM OpenBPython q i b
MapM OpenPTPython q i t
MapM OpenInPDB q i p
MapM OpenInPTPDB q i d
MapM OpenRangerHere q r
MapM MQQuit q q
MapM GoToTop g g
MapM FZFGit g i
MapM FZFHere g d
MapM InsertAtTop q t
MapM InsertAtTop q w t
MapM InsertAtBottomPaste q n p
MapM InsertAtBottom q w n
MapM InsertAtBottom q m
MapM InsertAtBottom q b
MapM InsertAtBottom q w m
MapM ForceQuit g q
MapM fzf#vim#buffers g n
MapM FZFHere g p
MapM OpenInEmacs g m
MapM OpenInYi t y
MapM OpenInRifle q e r
MapM GeneralSyntax q y

" remake these, maybe in emacs
"MapM CheckCode q y f
"MapM CheckIssue q y i
"MapM TestCode q y t
MapM WrapParagraph q w q
" MapM OpenInEmacsColour g c
MapM OpenContentsInEmacs g c
MapM OpenInVanillaVim q v
MapM GoWhich g w
" This is bad, I keep using <Esc>gw for go which
" MapM OpenInVanillaVim g w
MapM FilterWithFzf q f
MapM Bind1WithFzf q j
MapM TmuxGoogle(expand('<cword>')) q i
MapM EmacsOccurFileContents q e c
MapM EmacsOccurFileContents q e o
MapM RTGrepFilesInHere q e g
MapM OpenInPVD q e .
MapM WordFrequenciesPVD q g f
MapM ScopeCursor q p
MapM ScopeCursor q k p
MapM SubstituteSelection q u
"MapM OpenCtagsForThis q k t
MapM OpenSourceInfo q k t
MapM SearchCodeZ q h
MapM OpenSnippets q d
MapM DocumentationForThis q x
MapM NormalSplitThenTagbarToggle q k b
MapM GoOtherWindow q k l
MapM GoOtherWindow q k o
MapM CloseWindow q c
"MapM MinimiseAndWrap q g
" MapM OpenVimgrep('<C-r>/') q g i
MapM VimGrepWordAtCursor q g i
MapM RenameExtension q g n
MapM SelectType q g y
MapM SelectRefactoring g r f
MapM RemoveFactGlobally q r f

" can't start with g f
" MapM SelectFilter g f f

MapM OpenInMagitFile g h
MapM EscDollar g r d
MapM EraseBadWhitespace g r w
"MapM gf_ext#GoFileTmux(expand("<cfile>")) g e
MapM OpenFileInTmux(expand("<cfile>")) g e
MapM Anywhere_gf g f

" this doesn't work I think because the function runs a keyboard macro
" and I have Meta held down. So remove the macro
MapM CopyLineAndRunInTmux `
MapM Lines g s
MapM SelectVisual g a
MapM YcmTmux q g c
MapM GoBack g b
MapM CCTreeLoadDB q t t
" q t r will tell me what has called this function all the way up to main.
MapM CCTreeTraceReverse q t r
" q t f will tell me what this function calls all the way down to the leaf nodes -- it's introspective.
MapM CCTreeTraceForward q t f

fun! CCTreeLoadDB()
    let @* = g:cscope_path
    CCTreeLoadDB
endf

fun! CCTreeTraceForward()
    CCTreeTraceForward
endf

fun! CCTreeTraceReverse()
    CCTreeTraceReverse
endf

fun! GoBack()
    exe expand("normal! \<C-o>")
endf

fun! GoOtherWindow()
    exe expand("normal! \<C-w>w")
endf

fun! CloseWindow()
    exe expand("normal! \<C-w>c")
endf

fun! SearchCode(incmd)
    call system('tm -f -tout -S nw "is searchcode.com"', escape(fnameescape(escape(fnameescape(a:incmd), "#%()")), "#%()"))
endf

fun! SearchCodeZ()
    call system('tm -f -tout -S nw "is searchcode.com"', escape(fnameescape(escape(fnameescape(@z), "#%()")), "#%()"))
endf

xmap ZL "zy;call TmuxGoogle(@z)<CR>
nmap ZL viw"zy;call TmuxGoogle(@z)<CR>

xmap ZS "zy;call SearchCode(@z)<CR>
nmap ZS viw"zy;call SearchCode(@z)<CR>

nnoremap <Esc>3 :call FZFpreview()<CR>
nnoremap <Esc>2 :call ScopeThisFile()<CR>
nnoremap <Esc>1 :call ScopeCursor()<CR>

fun! GetCharDvorak()
    return system('dvorak', nr2char(getchar()))
endf


" SUPER IMPORTANT
function FindChar(mode, count)
    if a:mode ==# 'v'
        normal! gv
    endif

    let c = escape( GetCharDvorak(), "^.*$~")

    let @/=c

    let i=count
    if ! i > 0
        let i=1
    endif
    for i in range(1, i)
        let match = search(c)
    endfor
endfunction

nnoremap f :call FindChar('n', v:count1)<CR>
xnoremap f :<C-u>call FindChar('v', v:count1)<CR>

" SUPER IMPORTANT
function FindCharBack(mode, count)
    if a:mode ==# 'v'
        normal! gv
    endif

    let c = escape( GetCharDvorak(), "^.*$~")

    let @/=c

    let i=count
    if ! i > 0
        let i=1
    endif
    for i in range(1, i)
        let match = search(c, 'b')
    endfor
endfunction

nnoremap F :call FindCharBack('n', v:count1)<CR>
xnoremap F :<C-u>call FindCharBack('v', v:count1)<CR>

" I don't know how to use vim-repeat
" silent! call repeat#set("FindChar", v:count)
" silent! call repeat#set("FindCharBack", v:count)

" not sure what this is
" fun! Xcp(para)
"     let @x = system('tmux neww -d "xcp -n '.shellescape(a:para).'"')[:-2]
"     return ""
" endf

" silent, asynchonous sys
fun! Ssys(cmd)
    silent! call system(a:cmd." &>/dev/null &")
    return ""
endf

fun! SelectFileType()
    silent! call system("ls ".g:mygit."/neovim/runtime/syntax/ | sed -n 's/\\(.*\\).vim$/\\1/p' | fzf --sync | tm send-keys")
endf

fun! SelectRefactoringUsingFZF()
    silent! call system("cat ".g:myhome."/notes/ws/filters/refactorings.txt | sed 's/\\s*#[^#]*$//' | fzf --sync | tm send-keys")
endf

fun! SelectFilterUsingFZF()
    silent! call system("cat ".g:myhome."/notes/ws/filters/filters.sh | sed 's/\\s*#[^#]*$//' | fzf --sync | tm send-keys")
endf

" undo -- emacs compatibility
nnoremap <C-_> u
inoremap <C-_> <Esc>u
xmap <Esc>w y
nmap <Esc>y<Esc>p yp
" not really emacs but related
xmap <Esc>Y Y

function Openall()
    " You can then highlight the entire file (or the set of paths you
    " want to open) using visual mode (1G, Shift-V, G) and typing ":call
    " Openall()". Afterwards the command row will show this:

    " :'<,'>call Openall()

    edit <cfile>
    bfirst
endfunction

xnoremap X <C-h>x

xnoremap <Esc>q<Esc>g<Esc>g :g/^/normal! 

fun! VimGrepWordAtCursor()
    set hls
    let @/=expand('<cword>')
    if ! empty(@/)
        silent! GREP
        copen
        normal! n
    endif
endf

" This is annoying. Use something else instead
"nmap <2-LeftMouse> ;set hls<BAR>call VimGrepWordAtCursor()<CR>


nnoremap <silent> <leader>! :set opfunc=ProgramFilter<cr>g@
vnoremap <silent> <leader>! :<c-u>call ProgramFilter(visualmode(), 1)<cr>
function! ProgramFilter(vt, ...)
    let [qr, qt] = [getreg('"'), getregtype('"')]
    let [oai, ocin, osi, oinde] = [&ai, &cin, &si, &inde]
    setl noai nocin nosi inde=

    let [sm, em] = ['[<'[a:0], ']>'[a:0]]
    exe 'norm!`' . sm . a:vt . '`' . em . 'x'

    call inputsave()
    let cmd = input('!')
    call inputrestore()

    let out = system(cmd, @")
    let out = substitute(out, '\n$', '', '')
    exe "norm!i\<c-r>=out\r"

    let [&ai, &cin, &si, &inde] = [oai, ocin, osi, oinde]
    call setreg('"', qr, qt)
endfunction
" nmap <silent> <leader>@ \\!xa


" nmap K viwK
"
" This has to be a shell command
" let g:pydoc_cmd="TmuxPydoc"
" i.e. something who's $1 is the page to look up.
" let g:pydoc_cmd="TmuxPydoc"


" make & trigger :&& so it preserves flags
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>

" This is great and all but I don't want to have to type space.
" cabbrev \_. \_.\{-}

" cmap <Esc>a call TmuxGoogle(expand('<cword>'))<CR>
" cmap <Esc>i silent! call TmuxGoogle(expand('<cword>'))<CR>

fun! SelectVisual()
    "exe expand("normal! v//e")
    exe expand("normal! gn")
endf


cmap <Esc>a \_.\{-}
cmap <Esc>n g/^/normal 

"au BufEnter * silent! call AutoCtags()
"    I think the problem with opening files and therefore erasing my
"    files was that I was generating ctags every time I opened a file
"    in vim.
"    If I do this, don't make it happen every time.

fun! AutoCtags()
    " This updates cscope and ctags for an arbitrary git repository
    let @x = system('tm -f -d nw "cd \"'.GetGitDir().'\" && pwd; '.g:myhome.'/source/git/git_template/hooks/ctags"')[:-2]
    if v:shell_error == 0
        echom "success"
    endif
endf
command! AutoCtags call AutoCtags()

fun! YcmTmux()
    try
        let completions = youcompleteme#GetCompletions()
    catch 
        return
    endtry

    let @x = system("python -m json.tool | qtv", completions)[:-2]
    if v:shell_error == 0
        echom "success"
    endif
endf

" This is needed so projects in BULK get ctags and cscope generated
" for them. But this logic is duplicated in $VAS/.local.vimrc
fun! LoadCscopeMain()
    let cscope_path = GetGitConfigDir()."/cscope/cscope.out"
    if filereadable(cscope_path)
        let g:cscope_path = cscope_path
        silent! exec "cs add ".cscope_path
    endif
endf

autocmd BufEnter,BufRead *.{c,cpp,h,py,hy,go} call LoadCscopeMain()

" Devestating -- this deletes files when there is no filesystem lag.
" cmap <Esc>m silent! call AsyncSave()<CR>ZX
" AsyncSave and ZX do not mix

cmap <Esc>m <C-e><C-u>silent! call YRun()<CR>
cmap <Esc>d <C-e><C-u>bd!<CR>

abbrev fyi FYI:
abbrev fiy FYI:

" line
fun! CopySearchFile(sel)
    silent! call system('xc -m', 'vim +/"'.escape(a:sel,'"$*').'" "'.expand('%:p').'"')

    if v:shell_error == 0
        echom "success"
    endif
endf
xmap gy "zy;call CopySearchFile(@z)<CR>

xmap gG "zy;call system("tmux-rt-grep-files-in-here.sh -d", @z)<CR>

" For some reason,
" $VAS/.local.vimrc is not getting run sometimes.
if strpart(expand("%:p:h"), 0, 38) ==? g:myhome.'/projects/imm/imm_db_apps'
    let g:ycm_global_ycm_extra_conf = g:myhome.'/config/ycm-youcompleteme/immdbapps_ycm_extra_conf.py'
endif

"" I could start making mappings like this.
"xnoremap <Esc>s :s/
"cnoremap <Esc>s \S/

nnoremap F<Esc>d :set hls<CR>:let @/='[0-9]\+'<CR>N
nnoremap F<Esc>a :set hls<CR>:let @/='[a-z]\+'<CR>N
nnoremap F<Esc>A :set hls<CR>:let @/='[A-Z]\+'<CR>N
nnoremap F<Esc>s :set hls<CR>:let @/='\s\+'<CR>N
nnoremap F<Esc><CR> :set hls<CR>:let @/='^$'<CR>N
nnoremap F<Esc><Space> :set hls<CR>:let @/='\s\+'<CR>N
nnoremap F<Esc>S :set hls<CR>:let @/='[^a-zA-Z0-9   ]\+'<CR>N
nnoremap F<Esc>. :set hls<CR>:let @/='[^a-zA-Z0-9   ]\+'<CR>N
nnoremap F<Esc>c :set hls<CR>:let @/='\<[a-z]\{2,\}\>'<CR>N
nnoremap F<Esc>C :set hls<CR>:let @/='\<[A-Z]\{2,\}\>'<CR>N

nnoremap f<Esc>d :set hls<CR>:let @/='[0-9]\+'<CR>n
nnoremap f<Esc>a :set hls<CR>:let @/='[a-z]\+'<CR>n
nnoremap f<Esc>A :set hls<CR>:let @/='[A-Z]\+'<CR>n
nnoremap f<Esc>s :set hls<CR>:let @/='\s\+'<CR>n
nnoremap f<Esc><CR> :set hls<CR>:let @/='^$'<CR>n
nnoremap f<Esc><Space> :set hls<CR>:let @/='\s\+'<CR>n
nnoremap f<Esc>S :set hls<CR>:let @/='[^a-zA-Z0-9   ]\+'<CR>n
nnoremap f<Esc>. :set hls<CR>:let @/='[^a-zA-Z0-9   ]\+'<CR>n
nnoremap f<Esc>c :set hls<CR>:let @/='\<[a-z]\{2,\}\>'<CR>n
nnoremap f<Esc>C :set hls<CR>:let @/='\<[A-Z]\{2,\}\>'<CR>n

" autocmd TextChanged * silent! '[,']s/\s\+$//e | normal! `.

" This prevents \¤ from being inserted instead of what I expect.
inoremap \<Esc>$ \<Esc>$

autocmd BufEnter,WinEnter * call matchadd("Error", "\\<sudo\\>", -1)

" This has to be defined in the global scope so plugins can use it
let g:cscope_path = ""

if !hasmapto('<Plug>Commentary') || maparg('cm','n') ==# ''
  xmap cm  <Plug>Commentary
  nmap cm  <Plug>Commentary
  omap cm  <Plug>Commentary
  nmap cmc <Plug>CommentaryLine
  if maparg('c','n') ==# ''
    nmap cgc <Plug>ChangeCommentary
  endif
  nmap cmu <Plug>Commentary<Plug>Commentary
endif

" Occur - I already have <leader>gi thoug
nnoremap <Esc>g<Esc>/ :vimgrep /<C-R>//j %<CR>\|:cw<CR>

function! OpenVimgrep(pattern)
    "" It doesn't work unless the buffer has a file path.
    "normal yp
    call SaveTemp()
    exe "GrepBufs /".substitute(a:pattern, '\/', '\\/', 'g')."/ %"
    exe "silent! below copen ".(winheight(0) / 2)
endfunction

nnoremap <leader>gi :call OpenVimgrep('<C-r>/')<CR>
command! GREP :execute 'vimgrep '.expand('<cword>').' '.expand('%') | :belowright copen | :cc



" This is quite nice actually
function! Pmenu()
    let item_command = "find -maxdepth 3 -type f -regextype posix-egrep ! -regex '.*/(__pycache__|\.git|\.svn|node_modules)/.*' -printf '%P\\n'"
    if isdirectory("./.git")
        let item_command = "git ls-files"
    endif
    let cache_name = fnamemodify(getcwd(), ":t")
    let items = sort(systemlist(item_command))
    let current_item = expand("%:.")
    if !empty(current_item)
        let items = filter(copy(items), "v:val != " . shellescape(current_item))
    endif
    let selected_items = systemlist("pmenu -n " . shellescape(cache_name), items)
    if !empty(selected_items)
        execute "edit " . fnameescape(selected_items[0])
    endif
    redraw!
endfunction

" nnoremap <silent> <C-P> :call Pmenu()<CR>
" vnoremap <silent> <C-P> :call Pmenu()<CR>
"

" imap <C-j> <Plug>snipMateNextOrTrigger
" smap <C-j> <Plug>snipMateNextOrTrigger


imap <C-l> <Plug>snipMateNextOrTrigger
smap <C-l> <Plug>snipMateNextOrTrigger
" imap <C-l> <Plug>snipMateTrigger
" smap <C-l> <Plug>snipMateTrigger


" imap <expr> <m-h> pumvisible() ? '<esc>a<Plug>snipMateTrigger' : '<Plug>snipMateTrigger'
" imap <expr> <m-j> pumvisible() ? '<esc>a<Plug>snipMateNextOrTrigger' : '<Plug>snipMateNextOrTrigger'
" smap <m-j> <Plug>snipMateNextOrTrigger
" imap <expr> <m-k> pumvisible() ? '<esc>a<Plug>snipMateBack' : '<Plug>snipMateBack'
" smap <m-k> <Plug>snipMateBack
" imap <expr> <m-l> pumvisible() ? '<esc>a<Plug>snipMateShow' : '<Plug>snipMateShow'

nmap [h <Plug>GitGutterPrevHunk
nmap ]h <Plug>GitGutterNextHunk


" Fixes this
" Error detected while processing function gitgutter#process_buffer[17]..gitgutter#diff#handler[15]..gitgutter#sign#update_signs[1]..<SNR>204_find_current_signs:
let g:gitgutter_realtime = 0

" Not sure why these don't get sourced from inkpot anymore
map <F12> ;call ToggleCommentSyntax()<CR>
map <F11> ;call ToggleBrightness()<CR>
map <F10> ;call ToggleSyntax()<CR>

fun! TrueColor()
    set t_8f=^[[38;2;%lu;%lu;%lum        " set foreground color
    set t_8b=^[[48;2;%lu;%lu;%lum        " set background color
    "colorscheme Tomorrow-Night-Eighties
    set t_Co=256                         " Enable 256 colors
    set termguicolors                    " Enable GUI colors for the terminal to get truecolor
endf

" Haven't got this going yet (https://wiki.archlinux.org/index.php/st#Font)
"call TrueColor()


" invokes an default command mode shortcut(<C-\>e) for evaluating {expr}
" and replacing the whole command line with the result. strpart() is an
" string truncating function given by vim.
cnoremap <C-k> <C-\>estrpart(getcmdline(),0,getcmdpos()-1)<CR>
cnoremap <C-a> <C-b>
cnoremap <C-b> <left>

" Can't use C-f for right because it's used for opening the ex buffer in
" a window
"cnoremap <C-f> <right>

" this does not work
" cnoremap <C-o> <C-\>eOpenContentsInEmacs()<CR>


nnoremap <Esc>5 %
inoremap <Esc>5 <Esc>%

nnoremap <Esc>4 $
inoremap <Esc>4 <Esc>$

nnoremap <Esc>0 0
inoremap <Esc>0 <Esc>0

set foldcolumn=0 " margin, gutter

" As pretty as this looks, the lag on this laptop makes vim unusable
" au BufEnter * call GeneralSyntax()


" yp yf yg -- it's all in here
" $HOME$VIMCONFIG/common/bundle/vim-paste-replace/plugin/paste-replace.vim
" function! CopyGitPath(arg)
"     let sc=system("xa git-file-to-url | xc -n -i", a:arg)
"     echo sc
" endfunction
" nnoremap yg :call CopyGitPath(expand('%:p'))<CR>

function! CopyGitPathClink(arg)
    let sc=system("xa git-file-to-url | oc | xc -n -i", a:arg)
    echo sc
endfunction
function! CopyGitPathLine(arg)
    let sc=system("xa git-file-to-url | add-suffix '#L".line('.')."' | xc -n -i", a:arg)
    echo sc
endfunction
nnoremap yO :call CopyGitPathClink(expand('%:p'))<CR>
nnoremap yL :call CopyGitPathLine(expand('%:p'))<CR>

function! RTCmdSetup(cmd)
    exe("autocmd TextChanged * silent! call system(".Q(a:cmd).", GetBufferContents())")
    exe("autocmd TextChangedI * silent! call system(".Q(a:cmd).", GetBufferContents())")
endfunction

fun! StartAppend()
    startinsert
    call cursor( line('.'), col('.') + 1)
endf
command! StartAppend call StartAppend()
