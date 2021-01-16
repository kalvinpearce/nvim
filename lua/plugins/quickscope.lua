local g, cmd = vim.g, vim.cmd

g.qs_highlight_on_keys = { "f", "F", "t", "T" }
g.qs_max_chars = 150
cmd "highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline"
cmd "highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline"