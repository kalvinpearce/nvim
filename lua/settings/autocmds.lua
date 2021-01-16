local cmd = vim.cmd
local exec = vim.api.nvim_exec

cmd "au CursorHold * checktime"
cmd "au BufEnter * set fo-=c fo-=r fo-=o"
cmd "au TermOpen * setlocal signcolumn=no nonumber norelativenumber"

cmd "command!  -nargs=1 ReloadModule lua require('plenary.reload').reload_module(<q-args>)"
cmd "au BufWritePost *.lua :ReloadModule<CR>"

cmd "au CmdlineLeave : echo ''"

cmd "command! ReloadLSP lua reload_lsp()"
cmd "command! DebugLSP lua print(vim.inspect(vim.lsp.get_active_clients()))"
cmd "command! LogLSP lua open_lsp_log()"

-- Startuptime
exec([[
  if has('vim_starting') && has('reltime')
   let g:startuptime = reltime()
   augroup vimrc-startuptime
     autocmd!
     autocmd VimEnter * echomsg 'startuptime:' . reltimestr(reltime(g:startuptime))
   augroup END
 endif
]],"")