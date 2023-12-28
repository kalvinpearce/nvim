vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard

vim.opt.number = true -- enable line numbers
vim.opt.relativenumber = true -- enable relative numbers
vim.opt.signcolumn = "yes" -- always show sign column

vim.opt.tabstop = 2 -- spaces per tab
vim.opt.softtabstop = 2 -- spaces per tab
vim.opt.shiftwidth = 2 -- spaces per indentation
vim.opt.expandtab = true -- spaces over tabs (sorry Richard)
vim.opt.smartindent = true -- do indenting on new line

vim.opt.swapfile = false -- disable swapfile
vim.opt.backup = false -- disable backup
vim.opt.undofile = true -- enable persistent undo
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"

vim.opt.hlsearch = true -- show highlight when searching
vim.opt.incsearch = true -- show highlight of current search patter while typing
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- override ignorecase when searching with a captial

vim.opt.mouse = "a" -- enable mouse support
vim.opt.syntax = "on" -- enable syntax
vim.opt.showtabline = 1 -- show tabs when 2 or more visible
vim.opt.cursorline = true -- enable cursorline
vim.opt.wrap = false -- disable line wrapping
vim.opt.guifont = "Hack Nerd Font" -- my fav patched font
vim.opt.cmdheight = 2 -- more space for messages
vim.opt.showmode = false -- don't show current mode e.vim.g. INSERT
vim.opt.termguicolors = true -- truecolours for better experience
vim.opt.lazyredraw = true -- make macros faster by only redraw when finished
vim.opt.colorcolumn = "80" -- 80 chars color column (angry this is string)
vim.opt.completeopt = "menu,menuone,noinsert" -- better completion
vim.opt.scrolloff = 5 -- number of lines to keep above/below cursor when scrolling
vim.opt.sidescrolloff = 5 -- as above but for left/right scrolling

vim.opt.splitbelow = true -- force horizontal splits to go below
vim.opt.splitright = true -- force virtical splits to go right
vim.opt.equalalways = false -- don't adjust window size when creating new window

vim.opt.timeoutlen = 1000 -- wait a second for map sequence before cancelling
vim.opt.updatetime = 50 -- faster completion time

-- Misc fixes
vim.opt.iskeyword:append("-") -- don't split word on - char
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.sessionoptions = "buffers,curdir,folds,tabpages,winsize,terminal"

local force_formatopts = vim.api.nvim_create_augroup("ForctFormatOptions", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = force_formatopts,
  pattern = "*",
  command = "set formatoptions-=o",
})

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
