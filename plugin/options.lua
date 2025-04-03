vim.opt.clipboard = "unnamedplus" -- sync with system clipboard

vim.opt.number = true -- enable line numbers
vim.opt.relativenumber = true -- enable relative numbers
vim.opt.signcolumn = "yes" -- always show sign column

vim.opt.tabstop = 2 -- spaces per tab
vim.opt.softtabstop = 2 -- spaces per tab
vim.opt.shiftwidth = 2 -- spaces per indentation
vim.opt.expandtab = true -- spaces over tabs (sorry Richard)
vim.opt.smartindent = true -- do indenting on new line
vim.opt.conceallevel = 2

vim.opt.swapfile = false -- disable swapfile
vim.opt.backup = false -- disable backup
vim.opt.undofile = true -- enable persistent undo
vim.opt.undodir = os.getenv "HOME" .. "/.nvim/undodir"

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

vim.opt.inccommand = "split" -- show command output as you type

-- Misc fixes
vim.opt.iskeyword:append "-" -- don't split word on - char
vim.opt.whichwrap:append "<,>,[,],h,l"
vim.opt.sessionoptions = "buffers,curdir,folds,tabpages,winsize,terminal"

-- Folds
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"
-- Default to treesitter folding
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method "textDocument/foldingRange" then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})

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
  fold_virt_text(result, end_, vim.v.foldend - 1, #(end_str:match "^(%s+)" or ""))
  return result
end

vim.opt.foldtext = "v:lua.custom_foldtext()"

-- Don't have `o` add a comment
vim.opt.formatoptions:remove "o"
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
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrwSettings = 1
-- vim.g.loaded_netrwFileHandlers = 1
