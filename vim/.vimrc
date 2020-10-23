" =============================
" | .vimrc by Andrija Cicovic |
" =============================

" ============
" | Settings |
" ============

" Don't be compatible with Vi.
set nocompatible

" Set character encoding inside Vim as UTF-8.
set encoding=utf-8

" Encode file as UTF-8.
set fileencoding=utf-8

" Undo directory (make sure it exists).
set undodir=~/.vim/undodir

" Use undo file.
set undofile

" Enable syntax highlighting.
syntax on

" Detect filetype, and related plugins and indents.
filetype plugin indent on

" Plugins (managed by junegunn/vim-plug).
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
call plug#end()

" Colorscheme settings.
set background=dark
set termguicolors
colorscheme gruvbox
highlight Normal guibg=NONE ctermbg=NONE

" No error bells.
set noerrorbells

" Always show status line (down).
set laststatus=2

" Always show tab line (up).
set showtabline=2

" Don't show mode on last line (mode is shown in lightline).
set noshowmode

" Use relative line numbering.
set number relativenumber

" Set tabstop to 4 spaces.
set tabstop=4

" Set softtabstop to 4 spaces.
set softtabstop=4

" Expand tabs to spaces unless Ctrl-V+TAB is used.
set expandtab

" Indent by 4 spaces.
set shiftwidth=4

" Don't wrap lines.
set nowrap

" Highligh cursor line.
set cursorline

" Use incremental search.
set incsearch

" Don't highlight search results.
set nohlsearch

" Don't make windows equal size on split.
set noequalalways

" Make backspace act normally.
set backspace=indent,eol,start

" Show line break as a character.
set showbreak=↪\ 

" Visible whitespace characters when ':set list' is used.
set listchars=tab:→\ ,trail:•,space:·,eol:↲

" Add fzf directory to run time path after installation.
set rtp+=~/.fzf

" Update info every 100ms instead of default 800ms.
set updatetime=100

" <leader> key is space.
let mapleader = " "

" ============
" | Mappings |
" ============

" Mapping to insert empty line.
nnoremap <CR> o<Esc>k

" Mapping to show buffer list.
nnoremap <leader>] :ls<CR>:buffer<Space>

" Mapping to toggle visible whitespace characters.
nnoremap <leader>w :set list!<CR>

" Useful copy/paste mappings.
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "_dP

" Mapping to generate tags from make target 'tags'.
nnoremap <leader>t :silent make tags\|redraw!\|cc<CR>

" Mapping to open .vimrc in a new tab.
nnoremap <leader>v :silent tabnew ~/.vimrc<CR>

" Tab movement mappings.
nnoremap <Left> :silent tabprevious<CR>
nnoremap <Right> :silent tabnext<CR>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" Window movement / scrolling mappings.
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>
nnoremap <leader>l <C-w>l
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k

" =================
" | Auto-commands |
" =================

" C/C++ specific settings.
augroup CPROGLANG
    autocmd!
    autocmd filetype c,cpp set cindent
    autocmd filetype c,cpp set tags+=.tags
    autocmd filetype cpp set commentstring=//\ %s
augroup END

" Misc. autocmd settings.
augroup MISC
    autocmd!
    autocmd bufreadpost fugitive://* set bufhidden=delete
augroup END

" ===================
" | Plugin settings |
" ===================

" fzf configuration.
let g:fzf_layout = { 'window': {'width': 0.8, 'height': 0.8} }
let $FZF_DEFAULT_OPTS='--reverse'

" vim-go configuration.
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

" Startify configuration.
let g:startify_bookmarks = [{'v': '~/.vimrc'}]

" Lightline configuration.
let g:lightline = {
\ 'active': {
\   'left': [['mode', 'paste'], ['readonly', 'filename'], ['gitbranch']], 
\   'right': [['lineinfo'], ['filetype'], ['buff', 'filefmt', 'fileencoding']]
\ },
\ 'component': {
\   'filename': '%{LightlineFilename()}',
\   'gitbranch': '%{"\uE0A0 ".GitBranch()}',
\   'buff': '%n',
\   'filetype': '%{LightlineFiletype()}',
\   'filefmt': '%{LightlineFileformat()}'
\ },
\ 'separator': {'left': "\uE0B0", 'right': "\uE0B2"},
\ 'subseparator': {'left': "\uE0B1", 'right': "\uE0B3"},
\ }

" =============
" | Functions |
" =============

function! GitBranch()
    return exists("*FugitiveHead")?fugitive#head():"[Unknown]"
endfunction

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
