local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

opt.backup = false -- disable backup
opt.cursorline = true -- enable cursorline
opt.expandtab = true -- use spaces instead of tabs
opt.hidden = true -- keep hidden buffers
opt.ignorecase = true -- case insensitive on search
opt.lazyredraw = true -- lazyredraw to make macro faster
opt.number = true -- enable number
opt.relativenumber = true -- enable relativenumber
opt.showmode = false -- don't show mode
opt.smartcase = true -- improve searching using '/'
opt.smartindent = true -- smarter indentation
opt.splitbelow = true -- split below instead of above
opt.splitright = true -- split right instead of left
opt.swapfile = false -- disable swapfile
opt.termguicolors = true -- truecolours for better experience
opt.wrap = false -- dont wrap lines
opt.writebackup = false -- disable backup

opt.clipboard = 'unnamedplus' -- use system clipboard
opt.colorcolumn = '80' -- 80 chars color column (angry this is string)
opt.completeopt = { 'menuone,noinsert' } -- better completion
opt.formatoptions = 'qrn1' -- improve editor formatting
opt.guifont = 'Hack Nerd Font' -- set nerd font
opt.mouse = 'a'
opt.pastetoggle = '<F10>'
opt.shortmess = 'filnxtToOFIWc' -- disable some stuff on shortmess
opt.signcolumn = 'yes' -- enable sign column all the time, 4 column
opt.syntax = 'on' -- syntax enable

opt.cmdheight = 2
opt.conceallevel = 0
opt.pumheight = 20 -- limit completion items
opt.shiftwidth = 4 -- set indentation width
opt.timeoutlen = 400 -- faster timeout wait time
opt.updatetime = 100 -- set faster update time

if fn.has("win32") == 1 then
    -- Set shell to powershell
    cmd [[ let &shell = "powershell" ]]
    cmd [[ set shellquote= shellpipe=\| shellxquote= ]]
    cmd [[ set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command ]]
    cmd [[ set shellredir=\|\ Out-File\ -Encoding\ UTF8 ]]
end

-- Provider skips
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
