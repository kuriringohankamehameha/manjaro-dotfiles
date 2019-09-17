set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

"Set the same clipboard for X and vim
set clipboard=unnamedplus
vmap <C-c> "+y

"Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

function! TermVToggle(width)
    if win_gotoid(g:term_win)
        hide
    else
        botright vnew
        "exec "resize " a:width .
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction


" Toggle Horizontal Split terminal on/off (neovim)
nnoremap <A-z> :call TermToggle(12)<CR>
inoremap <A-z> <Esc>:call TermToggle(12)<CR>
tnoremap <A-z> <C-\><C-n>:call TermToggle(12)<CR>

" Toggle Vertical Split terminal on/off (neovim)
nnoremap <A-t> :call TermVToggle(12)<CR>
inoremap <A-t> <Esc>:call TermVToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermVToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR> 

" Shows Immediate feedback on substitute commands
set inccommand=split
