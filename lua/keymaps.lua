local g = vim.g
local cmd = vim.cmd
local api = vim.api
local tbl_extend = vim.tbl_extend

local function map(mode, key, result, opts)
	opts = tbl_extend("keep", opts or {}, {
		noremap = true,
		silent = true,
		expr = false,
	})
	api.nvim_set_keymap(mode, key, result, opts)
end

-- Map space leader
map("", "<Space>", "<Nop>")
g.mapleader = " "
g.maplocalleader = " "

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
map("o", "A", ":<C-U>normal! ggVG<CR>")

-- Remove force kill
map("n", "<C-z", "<Nop>")

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
--map("i", "<c-j>", "<down>")
--map("i", "<c-k>", "<up>")

-- Multi tab (complete/tab/move out of pairs)
map("i", "<TAB>", "pumvisible() ? '<C-y>' : search('\\%#[]>)}''\"`]', 'n') ? '<Right>' : '<TAB>'", { expr = true })

-- Better insert pasting
map("i", "<c-v>", "<F10><c-r>+<F10>")
cmd([[ cmap <C-V> <C-R>+ ]])

-- Save
map("n", "<c-s>", ":w<cr>")
map("x", "<c-s>", ":w<cr>")
map("i", "<c-s>", "<esc>:w<cr>a")

-- Close
map("n", "<c-q>", ":q<cr>")
map("n", "<c-w>", ":bd<cr>")

-- Line duplication
map("n", "<leader>dd", '"qyy"qp')
cmd([[xnoremap <silent> <Leader>dd "qy'>"qp]])

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==")
map("v", "<A-k>", ":m .-2<CR>==")
map("v", "p", '"_dP')
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Better terminal navigation
-- Not needed due to toggleterm mappings
-- map("t", "<C-h>", "<C-\\><C-N><C-w>h")
-- map("t", "<C-j>", "<C-\\><C-N><C-w>j")
-- map("t", "<C-k>", "<C-\\><C-N><C-w>k")
-- map("t", "<C-l>", "<C-\\><C-N><C-w>l")

-- Hard mode
map("n", "<left>", "<nop>")
map("n", "<right>", "<nop>")
map("n", "<up>", "<nop>")
map("n", "<down>", "<nop>")
map("i", "<left>", "<nop>")
map("i", "<right>", "<nop>")
map("i", "<up>", "<nop>")
map("i", "<down>", "<nop>")
map("x", "<left>", "<nop>")
map("x", "<right>", "<nop>")
map("x", "<up>", "<nop>")
map("x", "<down>", "<nop>")

-- Ctrl-backspace
map("i", "<c-bs>", "<c-w>")

return { map = map }
