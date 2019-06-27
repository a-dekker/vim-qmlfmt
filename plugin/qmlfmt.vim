" The "Vim qmlfmt" plugin runs qmlfmt and displays the results in Vim.
"
" Author:    Arno Dekker
" URL:       https://github.com/a-dekker/vim-qmlfmt
" Version:   0.1
" Copyright: Copyright (c) 2019 Arno Dekker
" License:   MIT
" ----------------------------------------------------------------------------

if exists('g:loaded_vimqmlfmt') || &cp || !executable('qmlfmt')
    finish
endif
let g:loaded_vimqmlfmt = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:qmlfmt_fmt_on_save')
    let g:qmlfmt_fmt_on_save = 0
endif

if !exists('g:qmlfmt_cmd')
    let g:qmlfmt_cmd = 'qmlfmt'
endif

" Options
if !exists('g:qmlfmt_extra_args')
    let g:qmlfmt_extra_args = ''
endif

let s:qmlfmt_switches = ['-t', '-i']

function! s:QmlfmtSwitches(...)
    return join(s:qmlfmt_switches, "\n")
endfunction

function! s:Qmlfmt(current_args)
    let l:extra_args = g:qmlfmt_extra_args
    let l:filename = @%
    let l:qmlfmt_cmd = g:qmlfmt_cmd
    let l:qmlfmt_opts = ' ' . a:current_args . ' ' . l:extra_args
    if a:current_args != ''
        let l:qmlfmt_opts = a:current_args
    endif
    let l:cursor_position = getcurpos()
    silent execute  "%!" . l:qmlfmt_cmd . ' ' . l:qmlfmt_opts
    if v:shell_error
        execute 'echom "qmlfmt returned an error, undoing changes. Often a syntax error, so check that."'
        " undo the buffer overwrite because qmlfmt returns no data on error, so we've erased the
        " user's work!
        undo
    endif
    " Reset the cursor position if we moved
    if l:cursor_position != getcurpos()
        call setpos('.', l:cursor_position)
    endif
endfunction

augroup qmlfmt
    autocmd!
    if get(g:, 'qmlfmt_fmt_on_save', 1)
        " Use BufWritePre to filter the file before it's written since we're
        " processing current buffer instead of the saved file.
        autocmd BufWritePre *.qml Qmlfmt
        autocmd FileType qml autocmd BufWritePre <buffer> Qmlfmt
    endif
augroup END

command! -complete=custom,s:QmlfmtSwitches -nargs=? Qmlfmt :call <SID>Qmlfmt(<q-args>)


let &cpo = s:save_cpo
