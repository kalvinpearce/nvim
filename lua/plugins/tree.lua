local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.g.nvim_tree_respect_buf_cwd = 1
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = true,
  update_cwd          = true,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
  },
  view = {
    width = 40,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {
          { key = {"<CR>", "o", "<2-LeftMouse>", "l"}, cb = tree_cb("edit") },
          { key = {"<BS>", "h"}, cb = tree_cb("close_node") },
      }
    }
  }
}
