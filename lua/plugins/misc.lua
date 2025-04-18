return {
  -- Enhanced increment/decrement plugin
  {
    "monaqa/dial.nvim",
    keys = {
      { mode = "n", "<C-a>" },
      { mode = "n", "<C-x>" },
      { mode = "v", "<C-a>" },
      { mode = "v", "<C-x>" },
      { mode = "v", "g<C-a>" },
      { mode = "v", "g<C-x>" },
    },
    config = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        default = {
          augend.constant.alias.bool, -- boolean value (true <-> false)
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
        },
      }

      local map = vim.keymap.set
      local dialMap = require "dial.map"
      map("n", "<C-a>", dialMap.inc_normal())
      map("n", "<C-x>", dialMap.dec_normal())
      map("v", "<C-a>", dialMap.inc_visual())
      map("v", "<C-x>", dialMap.dec_visual())
      map("v", "g<C-a>", dialMap.inc_gvisual())
      map("v", "g<C-x>", dialMap.dec_gvisual())
    end,
  },

  -- Smarter and more intuitive split pane management
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      local map = vim.keymap.set

      map("n", "<A-h>", require("smart-splits").resize_left)
      map("n", "<A-j>", require("smart-splits").resize_down)
      map("n", "<A-k>", require("smart-splits").resize_up)
      map("n", "<A-l>", require("smart-splits").resize_right)
      -- moving between splits
      map("n", "<C-h>", require("smart-splits").move_cursor_left)
      map("n", "<C-j>", require("smart-splits").move_cursor_down)
      map("n", "<C-k>", require("smart-splits").move_cursor_up)
      map("n", "<C-l>", require("smart-splits").move_cursor_right)
      map("n", "<C-\\>", require("smart-splits").move_cursor_previous)
      -- swapping buffers between windows
      map("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
      map("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
      map("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
      map("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
    end,
  },

  {
    "Shatur/neovim-session-manager",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("session_manager").setup {
        autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      }
    end,
  },
}
