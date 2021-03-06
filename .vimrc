" Syntax highlighting
syntax on
"colorscheme jellybeans
colorscheme synic

set encoding=utf-8
set fileformat=unix

" Enable mouse support everywhere
" (i.e. in console)
set mouse=a

" Line numbering and autoindent
set number
set autoindent
set smartindent
set foldmethod=syntax

" Show whitespace
set list

" Expand tabs -> spaces
set expandtab
set softtabstop=4
set shiftwidth=4

" Incremental Search Highlighting
" (Handy for building regexes)
set incsearch
" ...but then stop highlighting
set nohlsearch

" Required for some colorschemes
set t_Co=256

" Highlight long (>79 char) lines
set colorcolumn=80
hi colorcolumn ctermbg=6

" Open splits to right and below (reverse of default)
set splitbelow
set splitright

" Install plugins with Pathogen
execute pathogen#infect()
