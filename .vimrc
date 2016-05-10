" Syntax highlighting
syntax on
"colorscheme jellybeans
colorscheme synic

" Line numbering and autoindent
set number
set autoindent
set smartindent

" Show whitespace
set list

" Expand tabs -> spaces
set expandtab
set softtabstop=4
set shiftwidth=4

" Incremental Search Highlighting
" (Handy for building regexes)
set incsearch

" Required for some colorschemes
set t_Co=256

" Highlight long (>79 char) lines
set colorcolumn=80
hi colorcolumn ctermbg=6

" Open splits to right and below (reverse of default)
set splitbelow
set splitright
