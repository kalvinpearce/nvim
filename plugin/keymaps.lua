local utils = require "kp.utils"
local map = utils.map

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

-- Save
map({ "n", "x" }, "<leader>w", ":w<cr>", { desc = "Save file" })
map({ "n", "x" }, "<leader>bw", ":w<cr>", { desc = "Save file" })
map({ "n", "x" }, "<c-s>", ":w<cr>", { desc = "Save file" })
map({ "n", "x" }, "<d-s>", ":w<cr>", { desc = "Save file" })
map("i", "<c-s>", "<esc>:w<cr>a", { desc = "Save file" })
map("i", "<d-s>", "<esc>:w<cr>a", { desc = "Save file" })
-- Close
map("n", "<c-q>", ":q<cr>", { desc = "Close file" })
map("n", "<d-q>", ":q<cr>", { desc = "Close file" })
map("n", "<leader>q", ":q<cr>", { desc = "Close file" })

-- Line duplication
map("n", "<leader>dd", '"qyy"qp', { desc = "Duplicate line" })
map("x", "<leader>dd", [["qy'>"qp]], { desc = "Duplicate line" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<c-h>", require("smart-splits").move_cursor_left, { desc = "Go to left window" })
map("n", "<c-j>", require("smart-splits").move_cursor_down, { desc = "Go to lower window" })
map("n", "<c-k>", require("smart-splits").move_cursor_up, { desc = "Go to upper window" })
map("n", "<c-l>", require("smart-splits").move_cursor_right, { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<c-Left>", require("smart-splits").resize_left, { desc = "" })
map("n", "<c-Down>", require("smart-splits").resize_down, { desc = "" })
map("n", "<c-Up>", require("smart-splits").resize_up, { desc = "" })
map("n", "<c-Right>", require("smart-splits").resize_right, { desc = "" })

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

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
-- stylua: ignore
map("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

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
map("n", "<leader>us", utils.toggle_spell, { desc = "Toggle Spelling" })
map("n", "<leader>uw", utils.toggle_wrap, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", utils.toggle_line_numbers, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", utils.toggle_diagnostics, { desc = "Toggle Diagnostics" })
map("n", "<leader>uc", utils.toggle_conceal, { desc = "Toggle Conceal" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- On enter, clear search if it's on, otherwise just do "enter"
map("n", "<CR>", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.hlsearch:get() then
    vim.cmd.nohl()
    return ""
  else
    return "<CR>"
  end
end, { expr = true })