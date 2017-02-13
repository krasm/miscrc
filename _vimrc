filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

autocmd! bufwritepost .vimrc source %

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set number

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"indentation
au BufNewFile,BufRead *.py set textwidth=79 fileformat=unix

let mapleader = ","
" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

let g:pymode_options_colorcolumn = 1
