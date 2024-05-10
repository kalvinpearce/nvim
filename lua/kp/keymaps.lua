local Util = require("kp.utils")
local map = Util.map
local augroup = Util.augroup

-- Map space leader
map("", "<Space>", "<Nop>")

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
map("o", "A", ":<C-U>normal! ggVG<CR>")

-- Remove force kill
map({ "n", "v", "i", "c" }, "<C-z>", "<Nop>")

-- Paste without overwriting buffer
map("v", "p", '"_dP')
map("v", "<s-p>", "_dp")
-- Move to end of paste
map("n", "p", "p`]")
-- Better insert pasting
map("i", "<c-v>", [[<c-r><c-p>+]])
map("c", "<c-v>", [[<c-r><c-p>+]], { noremap = false })

-- -- Multi tab (complete/tab/move out of pairs)
-- map("i", "<TAB>", "pumvisible() ? '<C-y>' : search('\\%#[]>)}''\"`]', 'n') ? '<Right>' : '<TAB>'", { expr = true })

-- Save
map({ "n", "x" }, "<c-s>", ":w<cr>", { desc = "Save file" })
map({ "n", "x" }, "<d-s>", ":w<cr>", { desc = "Save file" })
map("i", "<c-s>", "<esc>:w<cr>a", { desc = "Save file" })
map("i", "<d-s>", "<esc>:w<cr>a", { desc = "Save file" })
-- Close
map("n", "<c-q>", ":q<cr>", { desc = "Close file" })
map("n", "<d-q>", ":q<cr>", { desc = "Close file" })
map("n", "<c-w>", ':lua require("mini.bufremove").delete(0, false)<cr>', { desc = "Close file" })
map("n", "<d-w>", ':lua require("mini.bufremove").delete(0, false)<cr>', { desc = "Close file" })

-- Line duplication
map("n", "<leader>dd", '"qyy"qp', { desc = "Duplicate line" })
map("x", "<leader>dd", [["qy'>"qp]], { desc = "Duplicate line" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Go to left window" })
map("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Go to lower window" })
map("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Go to upper window" })
map("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Left>", require("smart-splits").resize_left, { desc = "" })
map("n", "<C-Down>", require("smart-splits").resize_down, { desc = "" })
map("n", "<C-Up>", require("smart-splits").resize_up, { desc = "" })
map("n", "<C-Right>", require("smart-splits").resize_right, { desc = "" })

-- Swap buffers using <leader><leader> hjkl keys
map("n", "<leader><leader>h", require("smart-splits").swap_buf_left, { desc = "Swap buffer left" })
map("n", "<leader><leader>j", require("smart-splits").swap_buf_down, { desc = "Swap buffer down" })
map("n", "<leader><leader>k", require("smart-splits").swap_buf_up, { desc = "Swap buffer up" })
map("n", "<leader><leader>l", require("smart-splits").swap_buf_right, { desc = "Swap buffer right" })

-- Navigate buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("v", "J", ":move '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "K", ":move '<-2<cr>gv=gv", { desc = "Move up" })

-- Join lines stay in place
map("n", "J", "mzJ`z")

-- Center cursor when d/u & n/N jumping
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- n will always search forward, N will always search backward
-- regardless of / vs ? being used
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Search word but stay in place
map("n", "gw", "*N", { desc = "Search word under cursor" })
map("x", "gw", "*N", { desc = "Search word under cursor" })
-- noremap due to n/N remaps above
map("n", "n", "nzzzv", { noremap = false, desc = "Next search result" })
map("n", "N", "Nzzzv", { noremap = false, desc = "Prev search result" })
map("n", "{", "{zz", { desc = "Move to previous paragraph" })
map("n", "}", "}zz", { desc = "Move to next paragraph" })

-- toggle options
-- map("n", "<leader>uf", require("kp.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function()
  Util.toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
  Util.toggle("wrap")
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function()
  Util.toggle("relativenumber", true)
  Util.toggle("number")
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
  Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function()
    map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
    map("n", "<leader>ll", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
    map("n", "gd", function()
      require("telescope.builtin").lsp_definitions({ reuse_win = true })
    end, { desc = "Goto Definition" })
    map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
    map("n", "gI", function()
      require("telescope.builtin").lsp_implementations({ reuse_win = true })
    end, { desc = "Goto Implementation" })
    map("n", "gy", function()
      require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
    end, { desc = "Goto T[y]pe Definition" })
    map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
    map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
    map("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
    map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
    map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
    map("n", "<leader>lf", require("kp.utils").format, { desc = "Format Document" })
    map("v", "<leader>lf", require("kp.utils").format, { desc = "Format Range" })
    map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
    map("n", "<leader>lA", function()
      vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
    end, { desc = "Source Action" })
    map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
  end,
})
