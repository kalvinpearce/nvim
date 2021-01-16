local g, cmd = vim.g, vim.cmd

g.completion_sorting = "length"
g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }
g.completion_matching_smart_case = 1
g.completion_confirm_key = "\\<c-y>"
cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]