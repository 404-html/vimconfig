function! Translate(text, fromlang, tolang)
    return system('echo -n '.shellescape(a:text).' | speak.sh '.shellescape(a:fromlang).' '.shellescape(a:tolang)." translate |sed \"s/ '/'/g\"")
endfunction

function! Define(text)
    return system('sdcv '.shellescape(a:text))
endfunction

function! TmuxDictCC(text, fromlang, tolang)
    return system('speak.sh '.shellescape(a:fromlang).' '.shellescape(a:tolang).' '.shellescape(a:text)." translate |sed \"s/ '/'/g\"")
endfunction

function! Speak(text, lang)
    " need to use tmux so subprocesses will not try to use the terminal
    " also, so can fork the process and not kill it

    " have the tolang as en so that all the translations download, but
    " in reality, only speak the fromlang version in its own language
    silent! call system('killall -SIGINT speak.sh; tmux neww -d -n "speaking" "echo -n '.shellescape(a:text).' | speak.sh '.shellescape(a:lang).' en speak"')
    "normal! ;!echo -n '<C-R>=shellescape(a:text)<CR>' | speak.sh '<C-R>=shellescape(a:lang)<CR>)
    "exe '!echo -n '.shellescape(a:text).' | nohup speak.sh '.shellescape(a:lang)
endfunction

" not perfect. doesn't deal with newlines or forward slashes very well
" english (en) / french (fr) / german (de) / finnish (fi) / russian (ru) / italian (it) / hungarian (hu) /
" dutch netherlands (nl) / spanish (es) / swedish (sv) / japanese (ja) / latin (la) / norwegian (no)
" / greek (el) / danish (da) / romanian (ro) / malay (ms) / turkish (tr)
xmap <silent> Ztg "zxi<C-R>=Translate(@z, 'en', 'de')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Ztf "zxi<C-R>=Translate(@z, 'en', 'fr')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zti "zxi<C-R>=Translate(@z, 'en', 'fi')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Ztr "zxi<C-R>=Translate(@z, 'en', 'ru')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Ztt "zxi<C-R>=Translate(@z, 'en', 'it')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zth "zxi<C-R>=Translate(@z, 'en', 'hu')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Ztd "zxi<C-R>=Translate(@z, 'en', 'nl')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zte "zxi<C-R>=Translate(@z, 'en', 'es')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Ztw "zxi<C-R>=Translate(@z, 'en', 'sv')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Ztj "zxi<C-R>=Translate(@z, 'en', 'ja')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zta "zxi<C-R>=Translate(@z, 'en', 'la')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Ztn "zxi<C-R>=Translate(@z, 'en', 'no')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Ztk "zxi<C-R>=Translate(@z, 'en', 'el')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zty "zxi<C-R>=Translate(@z, 'en', 'da')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zto "zxi<C-R>=Translate(@z, 'en', 'ro')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Ztm "zxi<C-R>=Translate(@z, 'en', 'ms')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Ztu "zxi<C-R>=Translate(@z, 'en', 'tr')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Ztz "zxi<C-R>=Translate(@z, 'en', 'cs')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Ztg viW"zxi<C-R>=Translate(@z, 'en', 'de')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Ztf viW"zxi<C-R>=Translate(@z, 'en', 'fr')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zti viW"zxi<C-R>=Translate(@z, 'en', 'fi')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Ztr viW"zxi<C-R>=Translate(@z, 'en', 'ru')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Ztt viW"zxi<C-R>=Translate(@z, 'en', 'it')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zth viW"zxi<C-R>=Translate(@z, 'en', 'hu')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Ztd viW"zxi<C-R>=Translate(@z, 'en', 'nl')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zte viW"zxi<C-R>=Translate(@z, 'en', 'es')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Ztw viW"zxi<C-R>=Translate(@z, 'en', 'sv')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Ztj viW"zxi<C-R>=Translate(@z, 'en', 'ja')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zta viW"zxi<C-R>=Translate(@z, 'en', 'la')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Ztn viW"zxi<C-R>=Translate(@z, 'en', 'no')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Ztk viW"zxi<C-R>=Translate(@z, 'en', 'el')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zty viW"zxi<C-R>=Translate(@z, 'en', 'da')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zto viW"zxi<C-R>=Translate(@z, 'en', 'ro')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Ztm viW"zxi<C-R>=Translate(@z, 'en', 'ms')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Ztz viW"zxi<C-R>=Translate(@z, 'en', 'cs')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfg "zxi<C-R>=Translate(@z, 'de', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zff "zxi<C-R>=Translate(@z, 'fr', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfi "zxi<C-R>=Translate(@z, 'fi', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfr "zxi<C-R>=Translate(@z, 'ru', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zft "zxi<C-R>=Translate(@z, 'it', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfh "zxi<C-R>=Translate(@z, 'hu', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfd "zxi<C-R>=Translate(@z, 'nl', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfe "zxi<C-R>=Translate(@z, 'es', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfw "zxi<C-R>=Translate(@z, 'sv', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfj "zxi<C-R>=Translate(@z, 'ja', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfa "zxi<C-R>=Translate(@z, 'la', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfn "zxi<C-R>=Translate(@z, 'no', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfk "zxi<C-R>=Translate(@z, 'el', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfy "zxi<C-R>=Translate(@z, 'da', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfo "zxi<C-R>=Translate(@z, 'ro', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfm "zxi<C-R>=Translate(@z, 'ms', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfu "zxi<C-R>=Translate(@z, 'tr', 'en')<CR><ESC>;normal! `[v`]<CR>h
xmap <silent> Zfz "zxi<C-R>=Translate(@z, 'cs', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfg viW"zxi<C-R>=Translate(@z, 'de', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zff viW"zxi<C-R>=Translate(@z, 'fr', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfi viW"zxi<C-R>=Translate(@z, 'fi', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfr viW"zxi<C-R>=Translate(@z, 'ru', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zft viW"zxi<C-R>=Translate(@z, 'it', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfh viW"zxi<C-R>=Translate(@z, 'hu', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfd viW"zxi<C-R>=Translate(@z, 'nl', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfe viW"zxi<C-R>=Translate(@z, 'es', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfw viW"zxi<C-R>=Translate(@z, 'sv', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfj viW"zxi<C-R>=Translate(@z, 'ja', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfa viW"zxi<C-R>=Translate(@z, 'la', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfn viW"zxi<C-R>=Translate(@z, 'no', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfk viW"zxi<C-R>=Translate(@z, 'el', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfy viW"zxi<C-R>=Translate(@z, 'da', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfo viW"zxi<C-R>=Translate(@z, 'ro', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfm viW"zxi<C-R>=Translate(@z, 'ms', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfu viW"zxi<C-R>=Translate(@z, 'tr', 'en')<CR><ESC>;normal! `[v`]<CR>h
nmap <silent> Zfz viW"zxi<C-R>=Translate(@z, 'cs', 'en')<CR><ESC>;normal! `[v`]<CR>h

function! Speak(text, lang)
    " need to use tmux so subprocesses will not try to use the terminal
    " also, so can fork the process and not kill it
    silent! call system('killall -SIGINT speak.sh; tmux neww -d -n "speaking" "echo -n '.shellescape(a:text).' | speak.sh '.shellescape(a:lang).' '.shellescape(a:lang).' speak"')
    "normal! ;!echo -n '<C-R>=shellescape(a:text)<CR>' | speak.sh '<C-R>=shellescape(a:lang)<CR>)
    "exe '!echo -n '.shellescape(a:text).' | nohup speak.sh '.shellescape(a:lang)
endfunction

xmap <silent> Zsg "zy;call Speak(@z, 'de')<CR>
xmap <silent> Zsf "zy;call Speak(@z, 'fr')<CR>
xmap <silent> Zsi "zy;call Speak(@z, 'fi')<CR>
xmap <silent> Zsr "zy;call Speak(@z, 'ru')<CR>
xmap <silent> Zst "zy;call Speak(@z, 'it')<CR>
xmap <silent> Zsh "zy;call Speak(@z, 'hu')<CR>
xmap <silent> Zsd "zy;call Speak(@z, 'nl')<CR>
xmap <silent> Zse "zy;call Speak(@z, 'es')<CR>
xmap <silent> Zsw "zy;call Speak(@z, 'sv')<CR>
xmap <silent> Zsj "zy;call Speak(@z, 'ja')<CR>
xmap <silent> Zsa "zy;call Speak(@z, 'la')<CR>
xmap <silent> Zsn "zy;call Speak(@z, 'no')<CR>
xmap <silent> Zsk "zy;call Speak(@z, 'el')<CR>
xmap <silent> Zsy "zy;call Speak(@z, 'da')<CR>
xmap <silent> Zso "zy;call Speak(@z, 'ro')<CR>
xmap <silent> Zsm "zy;call Speak(@z, 'ms')<CR>
xmap <silent> Zsu "zy;call Speak(@z, 'tr')<CR>
xmap <silent> Zsz "zy;call Speak(@z, 'cs')<CR>
nmap <silent> Zsg viW"zy;call Speak(@z, 'de')<CR>
nmap <silent> Zsf viW"zy;call Speak(@z, 'fr')<CR>
nmap <silent> Zsi viW"zy;call Speak(@z, 'fi')<CR>
nmap <silent> Zsr viW"zy;call Speak(@z, 'ru')<CR>
nmap <silent> Zst viW"zy;call Speak(@z, 'it')<CR>
nmap <silent> Zsh viW"zy;call Speak(@z, 'hu')<CR>
nmap <silent> Zsd viW"zy;call Speak(@z, 'nl')<CR>
nmap <silent> Zse viW"zy;call Speak(@z, 'es')<CR>
nmap <silent> Zsw viW"zy;call Speak(@z, 'sv')<CR>
nmap <silent> Zsj viW"zy;call Speak(@z, 'ja')<CR>
nmap <silent> Zsa viW"zy;call Speak(@z, 'la')<CR>
nmap <silent> Zsn viW"zy;call Speak(@z, 'no')<CR>
nmap <silent> Zsk viW"zy;call Speak(@z, 'el')<CR>
nmap <silent> Zsy viW"zy;call Speak(@z, 'da')<CR>
nmap <silent> Zso viW"zy;call Speak(@z, 'ro')<CR>
nmap <silent> Zsm viW"zy;call Speak(@z, 'ms')<CR>
nmap <silent> Zsu viW"zy;call Speak(@z, 'tr')<CR>
nmap <silent> Zsz viW"zy;call Speak(@z, 'cs')<CR>

xmap <silent> Zss "zy;call Speak(@z, 'en')<CR>
nmap <silent> Zss viW"zy;call Speak(@z, 'en')<CR>

