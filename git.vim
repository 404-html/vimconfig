let b:cgitdir = ''
fun! GetGitDir()
    if !exists("b:cgitdir") || empty(b:cgitdir)
        let b:cgitdir = system('vc git get-top-level "'.expand('%:p').'"')[:-2]
    endif
    return b:cgitdir
endf

let b:cgitconfigdir = ''
fun! GetGitConfigDir()
    if !exists("b:cgitconfigdir") || empty(b:cgitconfigdir)
        let b:cgitconfigdir = system('vc git get-config-dir "'.expand('%:p').'"')[:-2]
    endif
    return b:cgitconfigdir
endf