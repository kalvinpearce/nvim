local g = vim.g
local tbl_extend = vim.tbl_extend

local function map(mode, key, result, opts)
	opts = tbl_extend("keep", opts or {}, {
		noremap = true,
	})
	vim.keymap.set(mode, key, result, opts)
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
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "<s-x>", "x")
map({ "n", "v" }, "d", '"_d')
map({ "n", "v" }, "<s-d>", "d")
map({ "n", "v" }, "c", '"_c')
map({ "n", "v" }, "<s-c>", "c")
map("v", "p", '"_dP')
map("v", "<s-p>", "p")

-- Move to end of paste
map("n", "p", "p`]")

-- Multi tab (complete/tab/move out of pairs)
map("i", "<TAB>", "pumvisible() ? '<C-y>' : search('\\%#[]>)}''\"`]', 'n') ? '<Right>' : '<TAB>'", { expr = true })

-- Better insert pasting
map("i", "<c-v>", "<F10><c-r>+<F10>")
map("c", "<c-v>", "<c-r>+", { noremap = false })

-- Save
map("n", "<c-s>", ":w<cr>")
map("x", "<c-s>", ":w<cr>")
map("i", "<c-s>", "<esc>:w<cr>a")

-- Close
map("n", "<c-q>", ":q<cr>")
map("n", "<c-w>", ":bd<cr>")
map("n", "<c-s-w>", ":e#<cr>")

-- Line duplication
map("n", "<leader>dd", '"qyy"qp')
map("x", "<leader>dd", [["qy'>"qp]])

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

-- Hard mode
map({ "n", "i", "x" }, "<left>", "<nop>")
map({ "n", "i", "x" }, "<right>", "<nop>")
map({ "n", "i", "x" }, "<up>", "<nop>")
map({ "n", "i", "x" }, "<down>", "<nop>")

-- Ctrl-backspace
map({ "i", "c", "t" }, "<c-h>", "<c-w>")

return { map = map }
