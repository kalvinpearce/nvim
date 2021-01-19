local map = require("settings.utils").map
local g = vim.g

g.signify_sign_add = "+"
g.signify_sign_delete = "_"
g.signify_sign_delete_first_line = "‾"
g.signify_sign_change = "~"

g.signify_sign_show_count = 0
g.signify_sign_show_text = 1

map("n", "<leader>gj", "<plug>(signify-next-hunk)")
map("n", "<leader>gk", "<plug>(signify-prev-hunk)")
