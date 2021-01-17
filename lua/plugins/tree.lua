local map = require("settings.utils").map
local api = vim.api

map("n", "<leader>e", ":NERDTreeToggle<cr>")

api.nvim_set_var("NERDTreeShowHidden", 1)
api.nvim_set_var("NERDTreeQuitOnOpen", 1)
