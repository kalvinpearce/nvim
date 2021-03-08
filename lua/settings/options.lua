local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

opt('o', 'backup', false) -- disable backup
opt('w', 'cursorline', true) -- enable cursorline
opt('o', 'expandtab', true) -- use spaces instead of tabs
opt('o', 'hidden', true) -- keep hidden buffers
opt('o', 'ignorecase', true) -- case insensitive on search
opt('o', 'lazyredraw', true) -- lazyredraw to make macro faster
opt('w', 'number', true) -- enable number
opt('w', 'relativenumber', true) -- enable relativenumber
opt('o', 'showmode', false) -- don't show mode
opt('o', 'smartcase', true) -- improve searching using '/'
opt('b', 'smartindent', true) -- smarter indentation
opt('o', 'splitbelow', true) -- split below instead of above
opt('o', 'splitright', true) -- split right instead of left
opt('b', 'swapfile', false) -- disable swapfile
opt('o', 'termguicolors', true) -- truecolours for better experience
opt('w', 'wrap', false) -- dont wrap lines
opt('o', 'writebackup', false) -- disable backup

opt('o', 'clipboard', 'unnamedplus') -- use system clipboard
opt('w', 'colorcolumn', '80') -- 80 chars color column (angry this is string)
opt('o', 'completeopt', 'menuone,noinsert') -- better completion
opt('b', 'formatoptions', 'qrn1') -- improve editor formatting
opt('o', 'guifont', 'Hack Nerd Font') -- set nerd font
opt('o', 'mouse', 'a')
opt('o', 'pastetoggle', '<F10>')
opt('o', 'shortmess', 'filnxtToOFIWc') -- disable some stuff on shortmess
opt('w', 'signcolumn', 'yes') -- enable sign column all the time, 4 column
opt('b', 'syntax', 'on') -- syntax enable

opt('o', 'cmdheight', 2)
opt('w', 'conceallevel', 0)
opt('o', 'pumheight', 20) -- limit completion items
opt('b', 'shiftwidth', 4) -- set indentation width
opt('o', 'timeoutlen', 400) -- faster timeout wait time
opt('o', 'updatetime', 100) -- set faster update time

if fn.has("win32") == 1 then
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
