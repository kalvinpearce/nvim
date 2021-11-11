local map = require("settings.utils").map

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
        ["<C-h>"] = "which_key"
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
require('telescope').load_extension('sessions')

 map("n", "<c-p>", "<cmd>Telescope find_files<cr>")

map("n", "gd", "<cmd>Telescope coc definitions<cr>", {noremap = false})
map("n", "gr", "<cmd>Telescope coc references<cr>", {noremap = false})
map("n", "gs", "<cmd>Telescope coc workspace_symbols<cr>", {noremap = false})
