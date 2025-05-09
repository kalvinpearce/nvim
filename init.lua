vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Setting options ]]
-- See `:help vim.opt`

-- General
vim.opt.backup = false -- Don't store backup while overwriting the file
vim.opt.mouse = "a" -- Enable mouse for all available modes
vim.opt.sessionoptions = "buffers,curdir,folds,tabpages,winsize,terminal" -- Remove some data from sessions
vim.opt.swapfile = false -- Disable swapfile
vim.opt.undofile = true -- Enable persistent undo (see also `:h undodir`)
vim.schedule(function()
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
end)

-- Appearance
vim.opt.breakindent = true -- Indent wrapped lines to match line start
vim.opt.colorcolumn = "100" -- 80 chars color column (angry this is string)
vim.opt.conceallevel = 2 -- Concealed text is completely hidden unless it has a custom replacement character defined
vim.opt.cursorline = true -- Highlight current line
vim.opt.linebreak = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.ruler = false -- Don't show cursor position in command line
vim.opt.scrolloff = 5 -- number of lines to keep above/below cursor when scrolling
vim.opt.showmode = false -- Don't show mode in command line
vim.opt.sidescrolloff = 5 -- as above but for left/right scrolling
vim.opt.signcolumn = "yes" -- Always show sign column (otherwise it will shift text)
vim.opt.splitbelow = true -- Horizontal splits will be below
vim.opt.splitright = true -- Vertical splits will be to the right
vim.opt.winborder = "rounded" -- Use rounded border for floating windows
vim.opt.wrap = false -- Display long lines as just one line

-- Editing
vim.opt.cindent = true -- Or else comments do not indent in visualmode + > or <
vim.opt.completeopt = "menuone,noinsert,noinsert,popup,fuzzy" -- Customize completions
vim.opt.expandtab = true -- spaces over tabs (sorry Richard)
vim.opt.formatoptions = "rqnl1j" -- Improve comment editing
vim.opt.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
vim.opt.inccommand = "split" -- show command output as you type
vim.opt.incsearch = true -- Show search results while typing
vim.opt.infercase = true -- Infer letter cases for a richer built-in keyword completion
vim.opt.iskeyword:append("-") -- don't split word on - char
vim.opt.lazyredraw = true -- make macros faster by only redraw when finished
vim.opt.shiftwidth = 2 -- spaces per indentation
vim.opt.smartcase = true -- Don't ignore case when searching if pattern has upper case
vim.opt.smartindent = true -- do indenting on new line
vim.opt.softtabstop = -1 -- Copy shiftwidth value
vim.opt.tabstop = 2 -- spaces per tab
vim.opt.updatetime = 250 -- faster completion time
vim.opt.virtualedit = "block" -- Allow going past the end of line in visual block mode
vim.opt.whichwrap:append("<,>,[,],h,l") -- Add directional keys to line wrapping

-- Spelling
vim.opt.spelllang = "en_us,en_au" -- Define spelling dictionaries
vim.opt.spelloptions = "camel" -- Treat parts of camelCase words as separate words

-- Folds
vim.opt.foldcolumn = "1" -- Show column for fold markers showing folded regions
vim.opt.foldenable = true -- Allow code regions to be folded
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Default to treesitter folding
vim.opt.foldlevel = 99 -- Open all folds
vim.opt.foldlevelstart = 99 -- Open all folds by default on new buffer
vim.opt.foldmethod = "expr" -- Pass folding onto custom foldexpr function
vim.opt.foldtext = "v:lua.custom_foldtext()" -- Use custom foldtext function
local function fold_virt_text(result, s, lnum, coloff)
  if not coloff then
    coloff = 0
  end
  local text = ""
  local hl
  for i = 1, #s do
    local char = s:sub(i, i)
    local hls = vim.treesitter.get_captures_at_pos(0, lnum, coloff + i - 1)
    local _hl = hls[#hls]
    if _hl then
      local new_hl = "@" .. _hl.capture
      if new_hl ~= hl then
        table.insert(result, { text, hl })
        text = ""
        hl = nil
      end
      text = text .. char
      hl = new_hl
    else
      text = text .. char
    end
  end
  table.insert(result, { text, hl })
end
function _G.custom_foldtext()
  local start = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
  local end_str = vim.fn.getline(vim.v.foldend)
  local end_ = vim.trim(end_str)
  local result = {}
  fold_virt_text(result, start, vim.v.foldstart - 1)
  table.insert(result, { " ... ", "Delimiter" })
  fold_virt_text(result, end_, vim.v.foldend - 1, #(end_str:match("^(%s+)") or ""))
  return result
end

-- Provider skips
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Plugin skips
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 0
vim.g.loaded_matchparen = 0
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- [[ Diagnostics ]]
vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

-- Enable the experimental Lua module loader
vim.loader.enable()

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local map = vim.keymap.set

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
map("o", "A", ":<C-U>normal! ggVG<CR>")

-- Remove force kill
map({ "n", "v", "i", "c" }, "<C-z>", "<Nop>")

-- Paste without overwriting buffer
map("v", "p", '"_dP')
map("v", "<s-p>", "_dp")
-- Move to end of paste
map("n", "p", "p`]")
-- Better insert pasting
map("i", "<c-v>", [[<c-r><c-p>+]])
map("c", "<c-v>", [[<c-r><c-p>+]], { noremap = false })

-- Cut with m
map({ "n", "x" }, "m", "d")
map("n", "mm", "dd")
map("n", "M", "D")
-- Use blackhole register for c,x,d
map({ "n", "x" }, "c", '"_c')
map({ "n", "x" }, "C", '"_C')
map({ "n", "x" }, "x", '"_x')
map({ "n", "x" }, "X", '"_X')
map({ "n", "x" }, "d", '"_d')
map({ "n", "x" }, "D", '"_D')

-- Save buffer
map("n", "<leader>w", ":w<cr>", { desc = "Save file" })
-- Close
map("n", "<c-q>", ":q<cr>", { desc = "Close file" })
map("n", "<leader>q", ":q<cr>", { desc = "Close file" })

-- Line duplication
map("n", "<leader>dd", '"qyy"qp', { desc = "Duplicate line" })
map("x", "<leader>dd", [["qy'>"qp]], { desc = "Duplicate line" })

-- Join lines stay in place
map("n", "J", "mzJ`z")

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
-- stylua: ignore
map("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- n will always search forward, N will always search backward
-- regardless of / vs ? being used
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Search word but stay in place
map("n", "gw", "*N", { desc = "Search word under cursor" })
map("x", "gw", "*N", { desc = "Search word under cursor" })
-- Center cursor when d/u & n/N & {/} jumping
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")
map("n", "{", "{zz", { desc = "Move to previous paragraph" })
map("n", "}", "}zz", { desc = "Move to next paragraph" })
-- noremap due to n/N remaps above
map("n", "n", "nzzzv", { noremap = false, desc = "Next search result" })
map("n", "N", "Nzzzv", { noremap = false, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Exit cmdline with <esc>
map("c", "<esc>", "<c-c>")

-- Health
map("n", "<leader>hh", "<cmd>checkhealth<cr>", { desc = "Vim Health" })
map("n", "<leader>hl", "<cmd>checkhealth vim.lsp<cr>", { desc = "Lsp Health" })

-- Toggle diagnostic lines
map("n", "<leader>uK", function()
  if vim.diagnostic.config().virtual_lines then
    vim.diagnostic.config({ virtual_lines = false })
  else
    vim.diagnostic.config({ virtual_lines = { current_line = true } })
  end
end, { desc = "Toggle diagnostic virtual_lines" })

-- LSP
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gri")
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format Code" })
map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })

-- [[ Automatic Commands ]]
-- See `:help autocmd

-- Don't have `o` add a comment
-- For some annoying reason this needs to be in an autocmd
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "set formatoptions-=o",
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  command = "tabdo wincmd =",
})

-- Open diagnostics on hover
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Close gitcommit buffer on save
-- Autocmd for git commit, callback adds local autocmd for BufWritePost
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit" },
  callback = function(event)
    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = event.buf,
      callback = function()
        -- hack to close the buffer as vim.api.nvim_win_close() doesn't work
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cmd>q<cr>", true, true, true), "n", true)
      end,
    })
  end,
})

-- Ensure wgsl files are correctly recognised
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end,
})

-- Ensure justfiles are correctly recognised
vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter", "BufRead", "BufNewFile" }, {
  pattern = { "justfile", ".justfile", "*.just" },
  callback = function()
    vim.cmd([[ setlocal filetype=just | setlocal commentstring=#\ %s ]])
  end,
})

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
  end,
})

-- Set up basic lsp loading spinner
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up lazy, and load `lua/kp/plugins/` folder
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.langs" },
  },
})
map("n", "<leader>L", ":Lazy<cr>", { desc = "Lazy" })
