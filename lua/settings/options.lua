local cmd = vim.cmd
local apply_options = require("settings.utils").apply_options

cmd "filetype plugin indent on"

apply_options({
    autoindent = true, -- enable autoindent
    backup = false, -- disable backup
    cursorline = true, -- enable cursorline
    expandtab = true, -- use spaces instead of tabs
    hidden = true, -- keep hidden buffers
    ignorecase = true, -- case insensitive on search
    lazyredraw = true, -- lazyredraw to make macro faster
    number = true, -- enable number
    relativenumber = true, -- enable relativenumber
    showmode = false, -- don't show mode
    smartcase = true, -- improve searching using '/'
    smartindent = true, -- smarter indentation
    splitbelow = true, -- split below instead of above
    splitright = true, -- split right instead of left
    swapfile = false, -- disable swapfile
    termguicolors = true, -- truecolours for better experience
    wrap = false, -- dont wrap lines
    writebackup = false, -- disable backup

    clipboard = "unnamedplus", -- use system clipboard
    completeopt = "menuone,noinsert", -- better completion
    encoding = "UTF-8", -- set encoding
    foldmethod = "marker", -- foldmethod using marker
    formatoptions = "qrn1", -- improve editor formatting
    mouse = "a",
    pastetoggle="<F10>",
    shortmess = "filnxtToOFIWc", -- disable some stuff on shortmess
    signcolumn = "yes", -- enable sign column all the time, 4 column
    syntax = "on", -- syntax enable

    cmdheight = 2,
    colorcolumn = 80, -- 120 chars color column
    conceallevel = 0,
    laststatus = 2, -- always enable statusline
    pumheight = 20, -- limit completion items
    shiftwidth = 4, -- set indentation width
    synmaxcol = 300, -- set limit for syntax highlighting in a single line
    timeoutlen = 400, -- faster timeout wait time
    updatetime = 100, -- set faster update time

})
