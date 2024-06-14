return {
  -- Cutlass overrides the delete operations to actually just delete and not affect the current yank
  {
    "gbprod/cutlass.nvim",
    config = function()
      require("cutlass").setup { cut_key = "m" }
    end,
  },

  -- Enhanced increment/decrement plugin
  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
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

      local map = require("kp.utils").map
      local dialMap = require "dial.map"
      map("n", "<C-a>", dialMap.inc_normal())
      map("n", "<C-x>", dialMap.dec_normal())
      map("v", "<C-a>", dialMap.inc_visual())
      map("v", "<C-x>", dialMap.dec_visual())
      map("v", "g<C-a>", dialMap.inc_gvisual())
      map("v", "g<C-x>", dialMap.dec_gvisual())
    end,
  },

  -- Multi cursor support
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },

  -- Branching undo tree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    },
  },

  -- Smarter and more intuitive split pane management
  {
    "mrjones2014/smart-splits.nvim",
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
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

  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
  },
}