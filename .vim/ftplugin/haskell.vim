" Vim filetype plugin file
" Language:         Haskell
" Maintainer:       Me
" Latest Revision:  

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = "setl com< cms< fo<"

setlocal comments=s1fl:{-,mb:-,ex:-},:-- commentstring=--\ %s
setlocal formatoptions-=t formatoptions+=croql
setlocal textwidth=0
"setlocal tabstop=4
setlocal softtabstop=4
setlocal expandtab
setlocal shiftwidth=4

let &cpo = s:cpo_save
unlet s:cpo_save
