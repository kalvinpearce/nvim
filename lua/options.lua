local o = vim.opt
local g = vim.g

o.mouse = "a" -- enable mouse support
o.syntax = "on" -- enable syntax
o.cursorline = true -- enable cursorline
o.relativenumber = true -- enable relative numbers
o.number = true -- enable line numbers
o.signcolumn = "yes" -- always show sign column
o.wrap = false -- disable line wrapping
o.guifont = "Hack Nerd Font" -- my fav patched font
o.clipboard = "unnamedplus" -- use system clipboard
o.cmdheight = 2 -- more space for messages
o.fileencoding = "utf-8" -- the encoding written to a file
o.swapfile = false -- disable swapfile
o.showmode = false -- don't show current mode e.g. INSERT
o.termguicolors = true -- truecolours for better experience
o.showtabline = 2 -- always show tabs
o.undofile = true -- enable persistent undo
o.lazyredraw = true -- make macros faster by only redraw when finished
o.expandtab = true -- spaces over tabs (sorry Richard)
o.shiftwidth = 2 -- spaces per indentation
o.tabstop = 2 -- spaces per tab
o.colorcolumn = "80" -- 80 chars color column (angry this is string)
o.completeopt = { "menu", "menuone", "noinsert" } -- better completion
o.ignorecase = true -- ignore case in search patterns
o.smartcase = true -- override ignorecase when searching with a captial
o.smartindent = true -- do indenting on new line
o.pumheight = 10 -- pop up menu height
o.splitbelow = true -- force horizontal splits to go below
o.splitright = true -- force virtical splits to go right
o.scrolloff = 10 -- number of lines to keep above/below cursor when scrolling
o.sidescrolloff = 5 -- as above but for left/right scrolling
o.timeoutlen = 1000 -- wait a second for map sequence before cancelling
o.updatetime = 300 -- faster completion time

-- Misc fixes
o.iskeyword:append("-") -- don't split word on - char
o.pastetoggle = "<F10>"
o.shortmess:append("c")
o.formatoptions = "qrn1" -- improve editor formatting
o.whichwrap:append("<,>,[,],h,l")
o.sessionoptions = "blank,buffers,curdir,folds,help,options,tabpages,winsize,terminal"

-- Provider skips
g.loaded_python_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
-- Plugin skips
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_matchit = 0
g.loaded_matchparen = 0
g.loaded_2html_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
