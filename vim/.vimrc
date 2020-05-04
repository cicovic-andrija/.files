" === Vim configuration by Andrija Cicovic
" === Vim > v8.0
"
" === Installed plugins (in no particular order):
"     - lightline.vim  [https://github.com/itchyny/lightline.vim]
"     - gruvbox        [https://github.com/morhetz/gruvbox]
"     - vim-fugitive   [https://github.com/tpope/vim-fugitive]
"     - auto-pairs     [https://github.com/jiangmiao/auto-pairs]
"     - nerdtree       [https://github.com/scrooloose/nerdtree]
"     - vim-go         [https://github.com/fatih/vim-go]
"
" How to install a plugin:
" ```
" $ git clone URL ~/.vim/pack/bundle/start/REPO_NAME
"
" ```
"
" === Font: Droid Sans Mono For Powerline Regular 11
"           [https://github.com/powerline/fonts]

" === Plugin settings.

" Use goimports as Go formatting tool.
let g:go_fmt_command = "goimports"

" NERDTree arrows.
let g:NERDTreeDirArrowExpandable = '📂'
let g:NERDTreeDirArrowCollapsible = '↳'

" Close Vim if the only windows left open is NERDTree.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
\    b:NERDTree.isTabTree()) | q | endif

" Open NERDTree if directory was specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) &&
\    !exists("s:std_in") | exe 'NERDTree' argv()[0] |
\    wincmd p | ene | exe 'cd '.argv()[0] | endif

" Lightline configuration.
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

" === Vim settings.

syntax on                       " === Enable syntax highlighting.
filetype plugin indent on       " === Enable plugins and indent files.
colorscheme gruvbox             " === Set color scheme.
set background=dark             " === Reset the color scheme to dark colors.
set nocompatible                " === Be iMproved (less Vi compatible).
set laststatus=2                " === Always show the status line.
set showtabline=2               " === Always show the tab line.
set encoding=utf-8              " === Use UTF-8 encoding inside Vim.
set fileencoding=utf-8          " === Encode files using UTF-8 encoding.
set noshowmode                  " === Hide mode message on the last line.
set number relativenumber       " === Show relative line numbers.
set tabstop=4                   " === Set tab width to 4 spaces.
set expandtab                   " === Replace tabs with 'tabstop' spaces.
set shiftwidth=4                " === Set level of indent. to 4 spaces.
set cursorline                  " === Highlight cursor line.
set incsearch                   " === Enable incremental search.
set hlsearch                    " === Highlight search results.
set termguicolors               " === Needed by the gruvbox color scheme.
set backspace=indent,eol,start  " === Make Backspace act 'normal'.
set completeopt=menu            " === Set completion options.

" Configure how whitespace characters will be shown.
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:·
set showbreak=↪\ 

" Show newline as well
"set listchars+=,eol:↲

" Configure folding characters.
if has('folding')
    if has('windows')
        set fillchars=vert:┃
        set fillchars+=fold:•
    endif
    set foldmethod=indent
    set foldlevelstart=99
    set foldtext=Foldtext()
endif

" === File type specific settings.

" Use smart indentation in C and C++ files.
autocmd FileType c,cpp :set cindent

" Set C++ comment type.
autocmd FileType cpp :set commentstring=//\ %s

" Auto-clean fugitive buffers.
autocmd BufReadPost fugitive://* set bufhidden=delete

" === Mappings.

" List open buffers.
nnoremap gb :ls<CR>:buffer<Space>

" Clear highlighted search results.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Insert empty line under the cursor.
nnoremap <CR> o<Esc>k

" Highlight a line.
nnoremap <silent> <leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>

" Trim trailing whitespace.
" NB: Use very carefully, don't make this an autocmd! Don't use on this file!
nnoremap ;tw :%s/\s\+$//e<CR>

" Toggle show whitespace characters.
nnoremap ;sw :set list!<CR>

" Toggle relative line numbering.
nnoremap ;rn :set relativenumber!<CR>

" Start a shell.
nnoremap ;; :shell<CR>

" Move to tab to the left or to the right.
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Go to tab by number.
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" Open/close NERDTree.
map <C-n> :NERDTreeToggle<CR>

" === Functions

let s:middot='•'
let s:raquo='»'
let s:small_l='ℓ'

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

function! Foldtext() abort
    let l:lines='[' . (v:foldend - v:foldstart + 1) . s:small_l . ']'         
    let l:first=substitute(getline(v:foldstart), '\v *', '', '')
    let l:dashes=substitute(v:folddashes, '-', s:middot, 'g')
    return s:raquo . s:middot . l:lines . l:dashes . ': ' . l:first
endfunction
