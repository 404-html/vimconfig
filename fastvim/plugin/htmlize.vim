" htmlize/unhtmlize a visual block
vnoremap <LocalLeader>h :call Htmlize()<CR>

" what a mess this function is...
function! Htmlize()
  let found = 0

  try
    execute ":s/&amp;/\\&/g"
    let found = 1
    execute ":s/&lt;/</g"
    let found = 1
    execute ":s/&gt;/>/g"
    let found = 1
  catch
    try
      execute ":s/&lt;/</g"
      let found = 1
      execute ":s/&gt;/>/g"
      let found = 1
    catch
      try
        execute ":s/&gt;/>/g"
        let found = 1
      catch
        " do nothing
      endtry
    endtry
  endtry

  if (found == 0)
    try
      execute ":s/&/\\&amp;/g"
      execute ":s/</\\&lt;/g"
      execute ":s/>/\\&gt;/g"
    catch
      try
        execute ":s/</\\&lt;/g"
        execute ":s/>/\\&gt;/g"
      catch
        try
          execute ":s/>/\\&gt;/g"
        catch
          " do nothing
        endtry
      endtry
    endtry
  endif
endfunction
