"
" init.vim by Andrija Cicovic
"

call plug#begin(stdpath('data') . '/plugged')
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-startify'
call plug#end()

syntax on
filetype plugin indent on
colorscheme gruvbox
set fileencoding=utf-8
set fileformat=unix
set exrc
set noerrorbells
set laststatus=2
set noshowmode
set number
set relativenumber
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set nowrap
set cursorline
set incsearch
set nohlsearch
set hidden
set noequalalways
set listchars=tab:→\ ,trail:•,space:·,eol:↲
set scrolloff=8
set completeopt=menuone,noinsert,noselect

augroup clang
autocmd!
autocmd filetype *.c,*.cpp set cindent
autocmd filetype *.c,*.cpp set tags+=.tags
autocmd filetype *.cpp set commentstring=//\ %s
augroup end

function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' [+]' : ''
    return filename . modified
endfunction

function! TrimTrailingWhitespace()
    execute '%s/\s\+$//e'
endfunction

let mapleader = " "
nnoremap <CR> o<Esc>k
nnoremap <leader>] :ls<CR>:buffer<Space>
nnoremap <leader>w :set list!<CR>
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "_dP
nnoremap <leader>s :Startify<CR>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <Left> :silent tabprevious<CR>
nnoremap <Right> :silent tabnext<CR>
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>
nnoremap <leader>l <C-w>l
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k

let g:lightline = {
\ 'active': {
\   'left': [['mode', 'paste'], ['readonly', 'filename']],
\   'right': [['lineinfo'], ['filetype'], ['buff', 'filefmt', 'fileencoding']]
\ },
\ 'component': {
\   'filename': '%{LightlineFilename()}',
\   'buff': '%n',
\   'filetype': '%{LightlineFiletype()}',
\   'filefmt': '%{LightlineFileformat()}'
\ },
\ 'separator': {'left': "\uE0B0", 'right': "\uE0B2"},
\ 'subseparator': {'left': "\uE0B1", 'right': "\uE0B3"},
\ }
let g:lightline.colorscheme = 'Tomorrow'
