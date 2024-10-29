return {
  {
    "echasnovski/mini.nvim",
    event = "VimEnter",
    name = "mini",
    version = false,
    init = function()
      -- replace nvim-web-devicons with mini.icons
      package.preload["nvim-web-devicons"] = function()
        package.loaded["nvim-web-devicons"] = {}
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    config = function(_, opts)
      -- Load all modules from opts
      for module, module_opts in pairs(opts) do
        if type(module_opts) == "function" then
          module_opts = module_opts()
        end

        require("mini." .. module).setup(module_opts)
      end

      vim.notify = require("mini.notify").make_notify()
    end,
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
      {
        "<leader>un",
        function()
          require("mini.notify").clear()
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      ai = function()
        local ai = require "mini.ai"
        return {
          n_lines = 500,
          custom_textobjects = {
            o = ai.gen_spec.treesitter({
              a = { "@block.outer", "@conditional.outer", "@loop.outer" },
              i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            }, {}),
            f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
            c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          },
        }
      end,
      bufremove = {},
      comment = {},
      cursorword = {},
      diff = {
        view = {
          style = "sign",
          signs = {
            add = "▎",
            change = "▎",
            delete = "",
          },
        },
      },
      hipatterns = function()
        local hipatterns = require "mini.hipatterns"
        return {
          highlighters = {
            fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
            hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
            todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
            note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
            hex_color = hipatterns.gen_highlighter.hex_color(),
          },
        }
      end,
      icons = {},
      move = {
        mappings = {
          left = "<",
          right = ">",
          down = "<S-j>",
          up = "<S-k>",
        },
      },
      notify = {
        content = {
          format = function(notif)
            return notif.msg
          end,
        },
        window = {
          winblend = 0,
        },
      },
      surround = {
        mappings = {
          add = "gza", -- Add surrounding in Normal and Visual modes
          delete = "gzd", -- Delete surrounding
          find = "gzf", -- Find surrounding (to the right)
          find_left = "gzF", -- Find surrounding (to the left)
          highlight = "gzh", -- Highlight surrounding
          replace = "gzr", -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`
        },
      },
    },
  },
}
