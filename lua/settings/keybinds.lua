local cmd = vim.cmd
local g = vim.g
local map = require("settings.utils").map

-- Map leader
map("n", "<space>", "<nop>")
g.mapleader = " "

-- Remove force kill
map("n", "<c-z>", "<nop>")

-- Quick exit 
map("i", "jk", "<esc>")
map("i", "kj", "<esc>")

-- Tab cycles buffer
map("n", "<tab>", ":bnext<cr>")
map("n", "<s-tab>", ":bprevious<cr>")

-- Better register actions
map("n", "x", '"_x')
map("v", "x", '"_x')
map("n", "<s-x>", "x")
map("v", "<s-x>", "x")
map("n", "d", '"_d')
map("v", "d", '"_d')
map("n", "<s-d>", "d")
map("v", "<s-d>", "d")
map("n", "c", '"_c')
map("v", "c", '"_c')
map("n", "<s-c>", "c")
map("v", "<s-c>", "c")
map("v", "p", '"_dP')
map("v", "<s-p>", "p")

-- Move to end of paste
map("n", "p", "p`]")

-- Beter completion nav
map("i", "<c-j>", "<down>")
map("i", "<c-k>", "<up>")
-- Multi tab (complete/tab/move out of pairs)
map("i", "<TAB>", "pumvisible() ? '<C-y>' : search('\\%#[]>)}''\"`]', 'n') ? '<Right>' : '<TAB>'", {expr = true})

-- Better insert pasting
map("i", "<c-v>", "<F10><c-r>+<F10>")

-- Better indenting
map("v", "<", "<gv")
map("n", "<", "<<")
map("n", ">", ">>")
map("v", ">", ">gv")

-- Save
map("n", "<c-s>", ":w<cr>")
map("x", "<c-s>", ":w<cr>")
map("i", "<c-s>", "<esc>:w<cr>a")

-- Close
map("n", "<c-q>", ":q<cr>")
map("n", "<c-w>", ':bd<cr>')

-- Line duplication
map("n", "<leader>dd", '"qyy"qp')
cmd [[xnoremap <silent> <Leader>dd "qy'>"qp]]

-- Moving between splits
map("n", "<c-j>", "<c-w><c-j>")
map("n", "<c-k>", "<c-w><c-k>")
map("n", "<c-l>", "<c-w><c-l>")
map("n", "<c-h>", "<c-w><c-h>")

-- Sizing window
map("n", "<a-right>", "<c-w>2<")
map("n", "<a-left>", "<c-w>2>")
map("n", "<a-up>", "<c-w>+2", {})
map("n", "<a-down>", "<c-w>-2")

-- Move selected text
map("x", "K", ":move '<-2<cr>gv-gv")
map("x", "J", ":move '>+1<cr>gv-gv")

-- Misc shortcuts
map("n", "<leader>.",  ":e $MYVIMRC<cr>")
map("n", "<leader>,",  ":Startify<cr>")
map("n", "<leader>/",  ":Commentary<cr>")

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
map("o", "A", ":<C-U>normal! ggVG<CR>")

map("n", "\\", "<cmd>BufferPick<CR>")