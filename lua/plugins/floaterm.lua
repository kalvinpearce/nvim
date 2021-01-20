local map = require("settings.utils").map
local g = vim.g

g.floaterm_autoclose = 1
g.floaterm_width = 0.85
g.floaterm_height = 0.85
g.floaterm_autoinsert = 1
g.floaterm_wintitle = 0
g.floaterm_gitcommit = 'floaterm'
g.floaterm_rootmarkers = {
    ".git",
    ".gitignore",
    "cargo.toml",
    "package.json"
}
g.floaterm_keymap_toggle = '<F1>'
g.floaterm_keymap_next   = '<F2>'
g.floaterm_keymap_prev   = '<F3>'
g.floaterm_keymap_new    = '<F4>'

map("n", "<leader>tt", ":FloatermToggle<CR>")
map("n", "<leader>tg", ":FloatermNew lazygit<CR>")
map("t", "<Esc><Esc>", "<C-\\><C-n>:FloatermToggle<CR>")
