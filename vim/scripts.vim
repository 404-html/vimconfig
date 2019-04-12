if did_filetype() 
  finish 
endif 

if getline(1) =~ '^#!/usr/bin/osascript' 
  setfiletype applescript 
"elseif getline(1) =~ '^#!/usr/bin/osascript' 
"  setfiletype applescript 
endif 
