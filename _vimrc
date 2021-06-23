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
set modeline

"backup files 
set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp

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
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

let mapleader = ","
" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" set background=light
" colorscheme solarized

set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

let g:ale_linters = {
      \   'python': ['flake8', 'pylint']
      \}
" disable ale by default - I am working on few crappy envs :(
let g:ale_enabled=0

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

let g:vimwiki_list = [{'path': '~/docs/vimwiki/'}]
