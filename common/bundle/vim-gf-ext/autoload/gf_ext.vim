" gf-ext.vim - Extend "gf" to open files with external programs
" Author: Daniel P. Wright (http://dpwright.com)

" vim: set foldlevel=1:

" Globals {{{1
let g:gf_ext_file_handlers = []
" }}}1

" Go-Functions {{{1
function! gf_ext#GoWhich(cmd)
  let rawname = substitute(a:cmd, "^\\s\\+","","")
  let rawname = substitute(rawname, "\\s\\+$", "", "")

  exe "e ".system("w \"".rawname."\"")
endfunction


function! gf_ext#GoFileTmux(cmd)
  let rawname = substitute(a:cmd, "^\\s\\+","","")
  let rawname = substitute(rawname, "\\s\\+$", "", "")
  let rawname = escape(rawname, "#%()")
  
  "let @x = system('ns '.escape(shellescape(rawname),"\""))[:-2]
  "if v:shell_error == 0
  "  echom "success"
  "endif

  " Need to make this try what's in the quotes so stuff like this works
  " #exec "$NOTES/scratch/glossary.sh"
  let unquotedname = substitute(rawname, '^[^"]*"\(.*\)"[^"]\+$', "\1", "")
  let rname = system("realpath \"".unquotedname."\"")[:-2]

  let ecmd = system("test -e \"".rname."\"")[:-2]
  let fexists = v:shell_error

  if ! fexists " if exists (because 0 exit code = true)
    let bname = system("basename \"".unquotedname."\"")[:-2]
    echom bname
    
    silent exe "!tm -d -te nw -n \"".bname."\" \"".rname."\"" | redraw!
    return
  endif

  " Remove comments and preprocessor directives from the start of lines
  if !empty(matchstr(rawname, '^#\(\l*\) '))
    let rawname = substitute(rawname, '^#\(\l*\) ',"","")
  endif

  "let a = system("echo \"" . rawname . "\" > /tmp/gf.txt")

  "let a=matchstr(rawname, 'localhost_\S\+')
  "if !empty(a)
  "  let b=matchstr(a, ':')
  "  " Needed to keep it from locking up when target doesn't have a :
  "  if !empty(b)
  "    let a = system("tmux-select.sh " . a)
  "  else
  "    let a = system("tmux-select.sh \"" . a . ":\"")
  "  endif
  "  return
  "endif

  "let a=matchstr(rawname, '^;\a*;[^;]*\(;.\+\)\?')
  "if !empty(a)
  "  silent exe '!tmux-tput-search.sh "'.a.'"' | redraw!
  "  return
  "endif

  "let a=matchstr(rawname, '^[@#%].\+')
  "if !empty(a)
  "  silent exe escape('!tmux-tput-search.sh "'.a.'"','%#%') | redraw!
  "  return
  "endif

  "let a=matchstr(rawname, '^P\:\\\S\+')
  "if !empty(a)
  "  silent exe '!open-winpath.sh "'.a.'"' | redraw!
  "  return
  "endif

  "let a=matchstr(rawname, '^http.\?:\S\+')
  "if !empty(a)
  "  silent exe '!tmux-elinks.sh "'.a.'"' | redraw!
  "  return
  "endif

  let a = system("echo \"" . rawname . "\" > /tmp/gf.txt")
  echom("echo \"" . rawname . "\" > /tmp/gf.txt")

  let rname = system("realpath \"".rawname."\"")[:-2]

  let ecmd = system("test -e \"".rname."\"")[:-2]
  let fexists = v:shell_error

  if ! fexists " if exists (because 0 exit code = true)
    let bname = system("basename \"".rawname."\"")[:-2]
    echom bname
    silent exe "!tm -d -te nw -n \"".bname."\" \"".rname."\"" | redraw!
    return
  endif

  if !empty(matchstr(rname, ' #'))
    let noncomment = substitute(rname, " #.*$","","")
    let ecmd = system("test -e \"".noncomment."\"")[:-2]
    let fexists = v:shell_error
    if ! fexists
      let bname = system("basename \"".noncomment."\"")[:-2]
      echom bname
      "silent exe "!tmux neww -t ".g:tmuxsession.": -n \"".bname."\" \"riflerun.sh \\\"".noncomment."\\\"\"" | redraw!
      silent exe "!tm -d -te nw -n \"".bname."\" \"".noncomment."\"" | redraw!
      return
    endif
  endif

  let bname = system("tm open-list-of-files-in-windows", rawname)[:-2]
  " silent exe "!tm -te -d nw -t ".g:tmuxsession.": -n \"".."\" \"gf \\\"".rawname."\\\"\"" | redraw!
  return

  echom "no file or folder found"
  throw "no file or folder found"
  "let output = system("vim-gf-systemcmd.sh \"".rawname."\"")[:-2]
  "if v:shell_error
  "echom output
endfunction


function! gf_ext#GoUrlTmux(cmd) " ק
  let rawname = substitute(a:cmd, "^\\s\\+","","")
  let rawname = substitute(rawname, "\\s\\+$", "", "")

  silent exe "!tm -d -te nw -n \"elinks\" \"".rawname."\"" | redraw!
endfunction


function! gf_ext#GoWhichTmuxRifle(cmd) " פ
  let rawname = substitute(a:cmd, "^\\s\\+","","")
  let rawname = substitute(rawname, "\\s\\+$", "", "")

  let bname = system("basename \"".rawname."\"")[:-2]
  let wname = system("which-mod \"".rawname."\"")[:-2]
  "echom 'bname: '.bname
  "echom 'wname: '.wname
  " redraw clears it
  "silent exe "!tmux-riflerun.sh \"".bname."\" \"".rawname."\"" | redraw!
  echom "!tm -d -te nw -n \"".bname."\" \"".rawname."\""
  "let res = system("tmux-rifle.sh \"".bname."\" \"".wname."\"")[:-2]
  let res = system("tm -d -te nw -d -n \"vim ".wname."\"")[:-2]
endfunction


function! gf_ext#GoLocate(cmd)
  let rawname = substitute(a:cmd, "^\\s\\+","","")
  let rawname = substitute(rawname, "\\s\\+$", "", "")

  "exe "e ".system("locate \"".rawname."\" | head -n 1")
  "exe "Ebuffers ".system("vimlocate \"".rawname."\" | head -n 10 | tr -s '\n' ' '")
  call system("locate \"".rawname."\" | tm -S -tout open-list-of-files-in-emacs")
endfunction

function! gf_ext#GoLocateTmuxRifle(cmd)
  let rawname = substitute(a:cmd, "^\\s\\+","","")
  let rawname = substitute(rawname, "\\s\\+$", "", "")

  " call system("locate \"".rawname."\" | tmux-neww-run-stdin.sh ecn &")

  "call system("locate \"".rawname."\" | tm -S -tout open-list-of-files-in-emacs")
  "
  call system("locate | tm -S -tout open-list-of-files-in-emacs", a:cmd)

  "call system("locate \"".rawname."\" | tmux-neww-run-stdin.sh 'vim -' &")

  "call system("notify-send 'gC opens all matching files in one vim'")
  "let lname = system("locate \"".rawname."\" | head -n 1")[:-2]
  "let bname = system("basename \"".lname."\"")[:-2]
  "echom bname
  "silent exe "!tmux neww -t ".g:tmuxsession.": -n \"".bname."\" \"riflerun.sh \\\"".lname."\\\"\"" | redraw!
endfunction

" get rid of this one. Seems redundant
" vim's gt
function! gf_ext#GoTmuxRifle(cmd)
  let rawname = substitute(a:cmd, "^\\s\\+","","")
  let rawname = substitute(rawname, "\\s\\+$", "", "")

  let bname = system("basename \"".rawname."\"")[:-2]
  echom bname
  
  " silent exe "!tmux neww -t ".g:tmuxsession.": -n \"".bname."\" \"riflerun.sh \\\"".rawname."\\\"\"" | redraw!
  "
  silent exe "!tm -d -te nw -n \"".bname."\" \"v \\\"".rawname."\\\"\"" | redraw!
endfunction
" }}}1

" vim's gu
function! gf_ext#GoSearchCroogle(cmd, count)
  let rawname = substitute(a:cmd, "^\\s\\+","","")
  let rawname = substitute(rawname, "\\s\\+$", "", "")

  let bname = system("basename \"".rawname."\"")[:-2]
  echom "croogle ".&ft." ".bname
  call system("tmux-tput-search.sh \";pack;;".rawname."&\"")
endfunction

" vim's gs
function! gf_ext#GoSearchCode(cmd, count)
  let rawname = substitute(a:cmd, "^\\s\\+","","")
  let rawname = substitute(rawname, "\\s\\+$", "", "")

  let bname = system("basename \"".rawname."\"")[:-2]
  echom "searchcode ".&ft." ".bname
  "echom "!tmux neww -t ".g:tmuxsession.": -n \"".bname."\" \"searchcode-vim.sh ".&ft." \\\"".rawname."\\\"\"" | redraw!
  "silent exe "!tmux neww -t ".g:tmuxsession.": -n \"".bname."\" \"searchcode-vim.sh ".a:count." ".&ft." \\\"".rawname."\\\"\"" | redraw!
  call system("gs-searchcode-vim.sh ".a:count." ".&ft, rawname)
endfunction

" vim's go
function! gf_ext#GoSearchStackOverflow(cmd)
  let rawname = substitute(a:cmd, "^\\s\\+","","")
  let rawname = substitute(rawname, "\\s\\+$", "", "")

  let bname = system("basename \"".rawname."\"")[:-2]
  echom "searchcode ".&ft." ".bname
  "echom "!tmux -t ".g:tmuxsession.": neww -n \"".bname."\" \"searchcode-vim.sh ".&ft." \\\"".rawname."\\\"\"" | redraw!
  "silent exe "!tmux -t ".g:tmuxsession.": neww -n \"".bname."\" \"searchcode-vim.sh ".a:count." ".&ft." \\\"".rawname."\\\"\"" | redraw!
  call system("go-stackoverflow-vim.sh ".&ft, rawname)
endfunction

 " Handlers {{{1
function! gf_ext#run_handler_for_file(file, count)
  "let s:use_path = exists('w:check_words') ? !w:check_words : 1
  let usepath=1
  let capture=a:file
  let capture = substitute(capture, "^\\s\\+","","")
  let capture = substitute(capture, "\\s\\+$", "", "")
  let origcapture = capture
  let capture = fnameescape(capture)

  if empty(capture)
    " Todo use localised error messages
    echo "E446: No file name under cursor"
  else
    let handled = 0
    let savecwd = getcwd()

    if !empty(matchstr(escape(capture," "), '^localhost_'))
      silent system("tmux-select.sh " . origcapture)
      return
    endif

    if !empty(matchstr(escape(capture," "), '^http://')) || !empty(matchstr(escape(capture," "), '^https://'))

      if !empty(matchstr(escape(capture," "), '?image'))
        silent exe "!fehweb " . shellescape(origcapture) . " &> /dev/null &" | exe ':redraw!'
      else
        silent exe "!webbrowser.sh " . shellescape(origcapture) . " &> /dev/null &" | exe ':redraw!'
      endif
      return
    endif
    if !empty(matchstr(escape(capture," "), '^magnet:\?'))
      if !empty(matchstr(escape(capture," "), '^magnet$'))
        normal! YY
        let capture=@z
      endif
      " to improve magnet links here, could substitute newlines for
      " spaces in capture
      silent exe "!tmux neww -t ".g:tmuxsession.": -n \"rt\" \"rtorrent \\\"" . capture . "\\\"\"" | exe ':redraw!'
      return
    endif
    let candidates = split(system("cd ".shellescape(g:gfpath)."; findfile.zsh ".escape(origcapture,"()").""),',')
    "let candidates = findfile(capture, "", -1)
    let idx = a:count == 0 ? 0 : a:count - 1
    if len(candidates) == 0
      if empty(matchstr(escape(capture," "), '\.'))
        let capture=capture.".js"
        let candidates = split(system("cd ".shellescape(g:gfpath)."; findfile.zsh ".escape(origcapture,"()").""),',')
      else
        " also search without using gfpath
        exec "cd ".savecwd
        "seems like this should be better but it causes bugs somehow
        "exec "cd \"".savecwd."\""
        " echo savecwd
        let usepath=0
        let candidates = findfile(a:file, "", -1)
      endif
    endif
    if len(candidates) > idx
      let path = candidates[idx]
      for handler in g:gf_ext_file_handlers
        if !empty(matchstr(path, handler["match"]))
          silent exe handler["handler"] . " " . path | exe ':redraw!'
          let handled = 1
          break
        endif
      endfor

      " not sure if escaping '#' for each of these cases is a good thing
      if !handled
          " unbuffer is needed because without it, it sometimes wont
          " output anything
          let vimtest=system("unbuffer rifle -l ".shellescape(escape(path,"#"))."|grep -E \"0:::(fast)?vim\"")
          if !empty(vimtest)
              if exists("g:gitid") && !empty("g:gitid")
                silent! exe "!git d ".escape(g:gitid, "!")." -- \"".path."\"" | exe ':redraw!'
              else
                if usepath
                  "exe "normal! gf"
                  if path =~ '^/'
                      exe "e ".escape(path, " ")
                  else
                      exe "e ".g:gfpath."/".escape(path, " ")
                  endif
                else
                  exe "e ".escape(path, " ")
                endif
              endif
          else
              if usepath
                "silent exe "!cd ".shellescape(g:gfpath)."; riflerun.sh \"" . escape(path,"#") . "\"" | exe ':redraw!'
                call RunInTmux("cd ".shellescape(g:gfpath)."; riflerun.sh \"" . escape(path,"#") . "\"") | exe ':redraw!'
              else
                "silent exe "!riflerun.sh \"" . escape(path,"#") . "\"" | exe ':redraw!'
                call RunInTmux("riflerun.sh \"" . escape(path,"#") . "\"") | exe ':redraw!'
              endif
          endif
      endif
    elseif len(candidates) == 0
      echo "E447: Can't find file \"" . capture . "\" in path"
    else
      echo "E347: No more file " . capture . " found in path"
    endif
  endif
endfunction

function! gf_ext#add_handler(filepattern, handler)
  let handler = {"match": a:filepattern, "handler": a:handler}
  call add(g:gf_ext_file_handlers, handler)
endfunction
" }}}1

" vim:set et sw=2:
