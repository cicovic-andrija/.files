set nocompatible                                  " don't be compatible with Vi
set encoding=utf-8                 " set character encoding inside Vim as UTF-8
set fileencoding=utf-8                                   " encode file as UTF-8
set undodir=~/.vim/undodir                " undo directory, make sure it exists
set undofile                                                    " use undo file
syntax on                                          " enable syntax highlighting
filetype plugin indent on    " detect filetype, and related plugins and indents
colorscheme gruvbox                                  " use gruvbox color scheme
set background=dark                   " (2) use dark and transparent background
highlight Normal guibg=NONE ctermbg=NONE
set laststatus=2                               " always show status line (down)
set showtabline=2                                   " always show tab line (up)
set noshowmode           " don't show Vim mode on last line (lightline is used)
set number relativenumber                         " use relative line numbering
set tabstop=4                                         " set tabstop to 4 spaces
set expandtab                 " expand tabs to spaces unless Ctrl-V+TAB is used
set shiftwidth=4                                           " indent by 4 spaces
set cursorline                                           " highligh cursor line
set incsearch                                          " use incremental search
set hlsearch                                         " highlight search results
set termguicolors                           " needed by gruvbox for some reason
set backspace=indent,eol,start                    " make backspace act normally
set showbreak=↪\                               " show line break as a character

                   " (2) visible whitespace characters when ':set list' is used
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:·
"set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:·,eol:↲

let mapleader = " "                                     " <leader> key is space
autocmd FileType c,cpp :set cindent      " set indendation mode for C/C++ files
autocmd FileType cpp :set commentstring=//\ %s " set comment type for C++ files

                                                             " show buffer list
nnoremap gb :ls<CR>:buffer<Space>
                                                         " clear search results
nnoremap <silent> <C-l> :nohl<CR><C-l>
                                                            " insert empty line
nnoremap <CR> o<Esc>k
       " trim trailing whitespace. use very carefully! do not use on this file!
nnoremap ;tw :%s/\s\+$//e<CR>
                                                          " (12) other mappings
nnoremap Q @q
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

                                                           " (5) netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_winsize = 25
autocmd FileType netrw set nolist

let g:user_emmet_leader_key=','                       " emmet plugin leader key
set rtp+=~/.fzf                   " add fzf directory to rtp after installation
autocmd BufReadPost fugitive://* set bufhidden=delete  " clear fugitive buffers
let g:go_fmt_command = "goimports"               " use goimports as fmt program
let g:go_auto_type_info = 1          " automatically show Go type/function info
set updatetime=100           " update info every 100ms instead of default 800ms
let g:go_auto_sameids = 1         " automatically highlight same Go identifiers

                                                           " lightline settings
let g:lightline = {
\ 'active': {
\   'left': [['mode', 'paste'],
\     ['readonly', 'filename'], ['gitbranch']], 
\   'right': [['lineinfo'], ['percent'],
\     ['fileformat', 'fileencoding', 'filetype']]
\ },
\ 'component': {
\   'gitbranch':
\   '%{exists("*fugitive#head")?"\uE0A0 ".fugitive#head():"\uE0A0 [No Branch]"}'
\ },
\ 'component_function': {
\   'fileformat': 'LightlineFileformat',
\   'filetype': 'LightlineFiletype',
\   'filename': 'LightlineFilename',
\ },
\ 'separator': {'left': "\uE0B0", 'right': "\uE0B2"},
\ 'subseparator': {'left': "\uE0B1", 'right': "\uE0B3"},
\ }

                                                                    " functions
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
