if exists('g:fvim_loaded')
    FVimCursorSmoothMove v:true
    FVimCursorSmoothBlink v:true
    FVimCustomTitleBar v:true
    " fvimbackgroundcomposition 'acrylic'   " 'none', 'transparent', 'blur' or 'acrylic'
    " fvimbackgroundopacity 0.85            " value between 0 and 1, default bg opacity.
    " fvimbackgroundaltopacity 0.85         " value between 0 and 1, non-default bg opacity.

    set guifont=Hack
    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif
