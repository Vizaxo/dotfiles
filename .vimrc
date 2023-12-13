syntax off
set nocompatible
"set list
"	set listchars+=tab:>-
"	set listchars+=trail:#

set wrap
set columns=80
set linebreak
set ignorecase
set smartcase
set showcmd

let mapleader = " "

"vimrc
noremap <leader>ve :e ~/.vimrc<CR>
noremap <leader>vr :source $MYVIMRC<CR>

"buffer
noremap <leader>bn :bn<CR>
noremap <leader>bp :bp<CR>
noremap <leader>bs :w<CR>

"make
noremap <leader>mm :!make<CR>
noremap <leader>mq :!make quick<CR>

"git
noremap <leader>gs :!git status<CR>
noremap <leader>ga :!git add .<CR>
noremap <leader>gc :!git commit<CR>
noremap <leader>gp :!git commit<CR>
noremap <leader>gd :!git diff<CR>
noremap <leader>gg :!git 
