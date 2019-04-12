" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
"    has problems when there is a line with only one non-whitespace character at
"    the start of the line.
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  "let virtualeditsave=&virtualedit
  "set virtualedit=
  let line = line('.')
  let column = virtcol('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal! " column . "|"
        "let &virtualedit=virtualeditsave
        return
      endif
    endif
  endwhile
  "let &virtualedit=virtualeditsave
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 0)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 0)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 0)<CR>zz
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 0)<CR>zz
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 0)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 0)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 0)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 0)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 0)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 0)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 0)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 0)<CR>