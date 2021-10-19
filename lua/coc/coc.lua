local map = require("settings.utils").map
local g = vim.g
local cmd = vim.cmd
local fn = vim.fn
local exec = vim.api.nvim_exec

g.coc_global_extensions = {
  "coc-marketplace",
  "coc-json",
  "coc-sumneko-lua",
  "coc-snippets",
  "coc-explorer",
  "coc-emmet",
  "coc-style-helper",
  "coc-prettier",
  "coc-tsserver",
  "coc-prisma",
  "coc-omnisharp",
  "coc-rust-analyzer",
  "coc-yank",
  "coc-spell-checker",
}

exec([[
    augroup CocUnderlineHighlights
        autocmd!
        autocmd ColorScheme * highlight CocErrorHighlight guisp=red gui=underline cterm=underline
        autocmd ColorScheme * highlight CocWarningHighlight guisp=yellow gui=underline cterm=underline
        autocmd ColorScheme * highlight CocHintHighlight guisp=#15aabf gui=underline cterm=underline
        autocmd ColorScheme * highlight CocInfoHighlight guisp=grey gui=underline cterm=underline
        autocmd ColorScheme * highlight CocInfoSign ctermfg=grey guifg=grey
    augroup END
]],"")

function show_docs()
  local cw = fn.expand("<cword>")
  if fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
    cmd("h " .. cw)
  elseif vim.api.nvim_eval("coc#rpc#ready()") then
    fn.CocActionAsync("doHover")
  else
    cmd("!" .. vim.o.keywordprg .. " " .. cw)
  end
end

map("n", "gh", "<CMD>lua show_docs()<CR>")

map("n", "<leader>cx", ":CocRestart<CR>", {silent = true})
map("n", "<Esc>", "coc#float#close_all()", {silent = true})

map("n", "<leader>e", "<cmd>CocCommand explorer<CR>", {})
map("n", "<leader><leader>", "<cmd>CocCommand explorer --position floating<CR>", {})
map("i", "<c-space>", "coc#refresh()", {expr = true})
cmd "nmap rn <Plug>(coc-rename)"

-- Use `[e` and `]e` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
map("n", "[e", "<Plug>(coc-diagnostic-prev)", {noremap = false})
map("n", "]e", "<Plug>(coc-diagnostic-next)", {noremap = false})

-- Multiple Cursors support
map("n", "gw", "<Plug>(coc-cursors-word)", {noremap = false})

-- GoTo code navigation.
map("n", "gy", "<Plug>(coc-type-definition)", {noremap = false})
map("n", "gi", "<Plug>(coc-implementation)", {noremap = false})

-- Format
map("x", "<leader>f", "<Plug>(coc-format-selected)", {noremap = false})
map("n", "<leader>f", "<Plug>(coc-format)", {noremap = false})

-- Remap keys for applying codeAction to the current buffer.
map("n", "<leader>a", "<Plug>(coc-codeaction-line)", {noremap = false})
map("x", "<leader>a", "<Plug>(coc-codeaction-selected)", {noremap = false})

map("n", "<leader>cq", "<Plug>(coc-fix-current)", {noremap = false})

-- Mappings for CoCList
-- Show all diagnostics.
map("n", "<leader>cd", ":CocFzfList diagnostics<CR>", {})
-- Show commands.
map("n", "<leader>cc", ":CocFzfList commands<CR>", {})
-- Show extensions.
-- map("n", "<leader>ce", ":CocFzfList extensions<CR>", {})
-- Find symbol of current document.
map("n", "<leader>co", ":CocFzfList outline<CR>", {})
-- Search workspace symbols.
map("n", "<leader>cs", ":CocFzfList -I symbols<CR>")
-- Open settings
map("n", "<leader>c.", ":CocConfig<CR>", {})
-- Coc-Yank
map("n", "<leader>y", ":<C-u>CocList -A --normal yank<cr>")

-- Fix coc explorer session bug?
cmd "set sessionoptions=buffers,curdir,folds,help,tabpages,winsize"

-- Snippets mappings
g.coc_snippet_next = '<c-l>'
g.coc_snippet_prev = '<c-h>'
