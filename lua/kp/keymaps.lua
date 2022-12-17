local g = vim.g
local map = require("kp.utils").map

-- Map space leader
map("", "<Space>", "<Nop>")
g.mapleader = " "
g.maplocalleader = " "

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
map("o", "A", ":<C-U>normal! ggVG<CR>")

-- Remove force kill
map({"n", "v", "i", "c" }, "<C-z>", "<Nop>")

-- System clipboard indegrations
map({"n", "v"}, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- Paste without overwriting buffer
map("v", "p", '"_dP')
map("v", "<s-p>", "_dp")
-- Move to end of paste
map("n", "p", "p`]")
-- Better insert pasting
map("i", "<c-v>", "<F10><c-r>+<F10>")
map("c", "<c-v>", "<c-r>+", { noremap = false })

-- -- Multi tab (complete/tab/move out of pairs)
-- map("i", "<TAB>", "pumvisible() ? '<C-y>' : search('\\%#[]>)}''\"`]', 'n') ? '<Right>' : '<TAB>'", { expr = true })

-- Save
map({"n", "x"}, "<c-s>", ":w<cr>")
map("i", "<c-s>", "<esc>:w<cr>a")
-- Close
map("n", "<c-q>", ":q<cr>")
map("n", "<c-w>", ":bd<cr>")
map("n", "<c-s-w>", ":e#<cr>")

-- Line duplication
map("n", "<leader>dd", '"qyy"qp')
map("x", "<leader>dd", [["qy'>"qp]])

-- Window navigation ctrl+hjkl
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize with ctrl+arrows
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
map("v", "J", ":move '>+1<CR>gv=gv")
map("v", "K", ":move '<-2<CR>gv=gv")

-- Ctrl-backspace
map({ "i", "c", "t" }, "<c-h>", "<c-w>")

-- Join lines stay in place
map("n", "J", "mzJ`z")

-- Center cursor when d/u & n/N jumping
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Save and run file
map("n", "<leader><leader>x", function()
	if vim.bo.filetype == "lua" then
		vim.cmd("write")
		vim.cmd("source %")
	end
end)

