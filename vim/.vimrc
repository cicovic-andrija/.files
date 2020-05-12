set nocompatible
set encoding=utf-8
set fileencoding=utf-8
syntax on
filetype plugin indent on
colorscheme gruvbox
set background=dark
set laststatus=2
set showtabline=2
set noshowmode
set number relativenumber
set tabstop=4
set expandtab
set shiftwidth=4
set cursorline
set incsearch
set hlsearch
set termguicolors " needed by gruvbox
set backspace=indent,eol,start " make Backspace act normal
set showbreak=↪\ 
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:·,eol:↲
"set list
autocmd FileType c,cpp :set cindent
autocmd FileType cpp :set commentstring=//\ %s
nnoremap gb :ls<CR>:buffer<Space>
nnoremap <silent> <C-l> :nohl<CR><C-l>
nnoremap <CR> o<Esc>k
nnoremap <silent> <leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>
" use very carefully; do not use on this file!
nnoremap ;tw :%s/\s\+$//e<CR>
nnoremap ;; :shell<CR>
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

" Plugin settings

" clear fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

let g:go_fmt_command = "goimports"

let g:NERDTreeDirArrowCollapsible = '↳'
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
\    b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) &&
\    !exists("s:std_in") | exe 'NERDTree' argv()[0] |
\    wincmd p | ene | exe 'cd '.argv()[0] | endif

let g:lightline = {
\   'active': {
\    'left': [['mode', 'paste'],
\        ['readonly', 'filename'], ['gitbranch']], 
\    'right': [['lineinfo'], ['percent'],
\        ['fileformat', 'fileencoding', 'filetype']]
\   },
\   'component': {
\    'gitbranch':
\    '%{exists("*fugitive#head")?"\uE0A0 ".fugitive#head():"\uE0A0 [No Branch]"}'
\   },
\   'component_function': {
\    'fileformat': 'LightlineFileformat',
\    'filetype': 'LightlineFiletype',
\    'filename': 'LightlineFilename',
\   },
\   'separator': {'left': "\uE0B0", 'right': "\uE0B2"},
\   'subseparator': {'left': "\uE0B1", 'right': "\uE0B3"},
\   }

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

