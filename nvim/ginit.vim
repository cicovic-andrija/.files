set guicursor=

let s:fontsize = 8
function! AdjustFontSize(amount)
    let s:fontsize = s:fontsize + a:amount
    execute "GuiFont! JetBrains Mono NL:h" . s:fontsize
endfunction

execute AdjustFontSize(s:fontsize)
execute "GuiTabline(0)"

nnoremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
nnoremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
inoremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
