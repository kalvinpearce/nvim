local g, cmd = vim.g, vim.cmd
local exec = vim.api.nvim_exec

g.qs_highlight_on_keys = { "f", "F", "t", "T" }
g.qs_max_chars = 150
g.qs_hi_priority = 10000
exec([[
    augroup qs_colors
        autocmd!
        autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
        autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
    augroup END
]],"")
