function SaveQuickFixList(fname)
    let list = getqflist()
    for i in range(len(list))
        if has_key(list[i], 'bufnr')
            let list[i].filename = fnamemodify(bufname(list[i].bufnr), ':p')
            unlet list[i].bufnr
        endif
    endfor
    let string = string(list)
    let lines = split(string, "\n")
    call writefile(lines, a:fname, "a")
endfunction

function LoadQuickFixList(fname)
    let lines = readfile(a:fname)
    let string = join(lines, "\n")
    call setqflist(eval(string))
endfunction
