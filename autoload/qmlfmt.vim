function! qmlfmt#qmlfmt(current_args, line1, line2) abort
    let l:extra_args = g:qmlfmt_extra_args
    let l:filename = @%
    let l:qmlfmt_cmd = g:qmlfmt_cmd
    let l:qmlfmt_opts = ' ' . a:current_args . ' ' . l:extra_args
    if !empty(a:current_args)
        let l:qmlfmt_opts = a:current_args
    endif
    let l:cursor_position = getcurpos()
    silent execute  a:line1 . ',' . a:line2 . '!' . l:qmlfmt_cmd . ' ' . l:qmlfmt_opts
    if v:shell_error
        echoerr '"qmlfmt returned an error, undoing changes. Often a syntax error, so check that."'
        " undo the buffer overwrite because qmlfmt returns no data on error, so we've erased the
        " user's work!
        undo
    endif
    " if we got no output, there was nothing to reformat: restore the buffer.
    if line('$') == 1 && getline(1) == ''
        silent undo
    endif
    " Reset the cursor position if we moved
    if l:cursor_position != getcurpos()
        call setpos('.', l:cursor_position)
    endif
endfunction
