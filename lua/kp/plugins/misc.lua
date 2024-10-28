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
    "smoka7/multicursors.nvim",
    dependencies = {
      "nvimtools/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<c-n>",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
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
    keys = {
      -- Move to window using the <ctrl> hjkl keys
      { mode = "n", "<c-h>", desc = "Go to left window" },
      { mode = "n", "<c-j>", desc = "Go to lower window" },
      { mode = "n", "<c-k>", desc = "Go to upper window" },
      { mode = "n", "<c-l>", desc = "Go to right window" },

      -- Resize window using <ctrl> arrow keys
      { mode = "n", "<C-S-h>" },
      { mode = "n", "<C-S-j>" },
      { mode = "n", "<C-S-k>" },
      { mode = "n", "<C-S-l>" },
    },
    config = function()
      local map = require("kp.utils").map

      -- Move to window using the <ctrl> hjkl keys
      map("n", "<c-h>", require("smart-splits").move_cursor_left, { desc = "Go to left window" })
      map("n", "<c-j>", require("smart-splits").move_cursor_down, { desc = "Go to lower window" })
      map("n", "<c-k>", require("smart-splits").move_cursor_up, { desc = "Go to upper window" })
      map("n", "<c-l>", require("smart-splits").move_cursor_right, { desc = "Go to right window" })

      -- Resize window using <ctrl> arrow keys
      map("n", "<C-S-h>", require("smart-splits").resize_left, { desc = "" })
      map("n", "<C-S-j>", require("smart-splits").resize_down, { desc = "" })
      map("n", "<C-S-k>", require("smart-splits").resize_up, { desc = "" })
      map("n", "<C-S-l>", require("smart-splits").resize_right, { desc = "" })
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_command_for_global = 1
      vim.g.mkdp_combine_preview = 1

      ---Fixes "No command :MarkdownPreview"
      ---https://github.com/iamcco/markdown-preview.nvim/issues/585#issuecomment-1724859362
      local function load_then_exec(cmd)
        return function()
          vim.cmd.delcommand(cmd)
          require("lazy").load { plugins = { "markdown-preview.nvim" } }
          vim.api.nvim_exec_autocmds("BufEnter", {}) -- commands appear only after BufEnter
          vim.cmd(cmd)
        end
      end
      for _, cmd in pairs { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" } do
        vim.api.nvim_create_user_command(cmd, load_then_exec(cmd), {})
      end
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
