" don't be compatible with Vi
set nocompatible

" set character encoding inside Vim as UTF-8
set encoding=utf-8

" encode file as UTF-8
set fileencoding=utf-8

" undo directory, make sure it exists
set undodir=~/.vim/undodir

" use undo file
set undofile

" enable syntax highlighting
syntax on

" detect filetype, and related plugins and indents
filetype plugin indent on

" colorscheme settings
set background=dark
set termguicolors
colorscheme gruvbox
highlight Normal guibg=NONE ctermbg=NONE

" no error bells!
set noerrorbells

" always show status line (down)
set laststatus=2

" always show tab line (up)
set showtabline=2

" don't show mode on last line (mode is shown in lightline)
set noshowmode

" use relative line numbering
set number relativenumber

" set tabstop to 4 spaces
set tabstop=4

" set softtabstop to 4 spaces
set softtabstop=4

" expand tabs to spaces unless Ctrl-V+TAB is used
set expandtab

" indent by 4 spaces
set shiftwidth=4

" don't wrap lines
set nowrap

" highligh cursor line
set cursorline

" use incremental search
set incsearch

" highlight search results
set hlsearch

" don't make windows equal size on split
set noequalalways

" make backspace act normally
set backspace=indent,eol,start

" show line break as a character
set showbreak=↪\ 

" visible whitespace characters when ':set list' is used
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:·,eol:↲

" <leader> key is space
let mapleader = " "

" mapping to insert empty line
nnoremap <CR> o<Esc>k

" mapping to clear search results
nnoremap <silent> <C-l> :nohl<CR><C-l>

" mapping to show buffer list
nnoremap <leader>] :ls<CR>:buffer<Space>

" mapping to trim trailing whitespace. use very carefully! not on this file!
nnoremap <leader>tw :%s/\s\+$//e<CR>

" mapping to toggle visible whitespace characters
nnoremap <leader>sl :set list!<CR>

" tab movement mappings
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_winsize = 25
autocmd FileType netrw set nolist

" set indendation mode for C/C++ files
autocmd FileType c,cpp :set cindent

" set comment type for C++ files
autocmd FileType cpp :set commentstring=//\ %s

" add fzf directory to rtp after installation
set rtp+=~/.fzf

" clear fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" use goimports as Go fmt program
let g:go_fmt_command = "goimports"

" automatically show Go type/function info
let g:go_auto_type_info = 1

" update info every 100ms instead of default 800ms
set updatetime=100

" lightline settings and functions
let g:lightline = {
\ 'active': {
\   'left': [['mode', 'paste'], ['readonly', 'filename'], ['gitbranch']], 
\   'right': [['lineinfo'], ['filetype'],
\     ['buffer', 'register', 'fileformat', 'fileencoding']]
\ },
\ 'component': {
\   'filename': '%{LightlineFilename()}',
\   'gitbranch': '%{"\uE0A0 ".GitBranch()}',
\   'register': '%{v:register}',
\   'buffer': '[%n]',
\   'filetype': '%{LightlineFiletype()}',
\   'fileformat': '%{LightlineFileformat()}'
\ },
\ 'separator': {'left': "\uE0B0", 'right': "\uE0B2"},
\ 'subseparator': {'left': "\uE0B1", 'right': "\uE0B3"},
\ }

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
    let filename = expand('%:p') !=# '' ? expand('%:p') : '[No Name]'
    let modified = &modified ? ' [+]' : ''
    return filename . modified
endfunction

" status line settings when plugin isn't used
"set statusline=\ %F
"set statusline+=\ [%4lL][%3cC]
"set statusline+=%<
"set statusline+=[%2p%%]
"set statusline+=[reg\ %{v:register}][buf\ %n]
"set statusline+=%y[%{&fileencoding?&fileencoding:&encoding}]%m%r%h
