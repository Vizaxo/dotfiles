set nocompatible
syntax off

set list
set listchars=tab:·\ 	"Show tab characters
set wrap
set columns=80
set linebreak
set ignorecase
set smartcase		"Smart case searching
set showcmd
set incsearch		"Incremental searching
set ttimeoutlen=0

"Highlight trailing whitespace (other than on the line currently being written)
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

"Leader commands
let mapleader = " "

"vimrc
noremap <leader>ve :e ~/.vimrc<CR>
noremap <leader>vr :source $MYVIMRC<CR>

"buffer
noremap <leader>bn :bn<CR>
noremap <leader>bp :bp<CR>
noremap <leader>bs :w<CR>
noremap <leader>bl :buffers<CR>
noremap <leader>b1 :b1<CR>
noremap <leader>b2 :b2<CR>
noremap <leader>b3 :b3<CR>
noremap <leader>b4 :b4<CR>
noremap <leader>b5 :b5<CR>
noremap <leader>b6 :b6<CR>
noremap <leader>b7 :b7<CR>
noremap <leader>b8 :b8<CR>
noremap <leader>b9 :b9<CR>

"make
noremap <leader>mm :!make<CR>
noremap <leader>mq :!make quick<CR>
noremap <leader>mc :!make clean<CR>

"git
noremap <leader>gg :!git 
noremap <leader>gs :!git status<CR>
noremap <leader>ga. :!git add %<CR>
noremap <leader>gaa :!git add --all<CR>
noremap <leader>gl :!git log --oneline --graph<CR>
noremap <leader>gcc :!git commit<CR>
noremap <leader>gca :!git commit --amend<CR>
noremap <leader>gp :!git push<CR>
noremap <leader>gd :!git diff --color-words %<CR>
noremap <leader>gb :!git blame %<CR>

