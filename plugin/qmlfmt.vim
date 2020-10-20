" The "Vim qmlfmt" plugin runs qmlfmt and displays the results in Vim.
"
" Author:    Arno Dekker
" URL:       https://github.com/a-dekker/vim-qmlfmt
" Version:   0.2
" Copyright: Copyright (c) 2019-2020 Arno Dekker
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

command! -range=% -complete=custom,s:QmlfmtSwitches -nargs=? Qmlfmt :call qmlfmt#qmlfmt(<q-args>, <line1>, <line2>)

augroup qmlfmt
    autocmd!
    if get(g:, 'qmlfmt_fmt_on_save', 1)
        " Use BufWritePre to filter the file before it's written since we're
        " processing current buffer instead of the saved file.
        autocmd BufWritePre *.qml Qmlfmt
        autocmd FileType qml autocmd BufWritePre <buffer> Qmlfmt
    endif
augroup END

let &cpo = s:save_cpo
