autocmd BufNewFile *.java
 \ exe "normal ipublic class " . expand('%:t:r') .
 \ " {\npublic " .expand('%:t:r') "() {\n}\n}\<Esc>ggj"