return {
  {
    "echasnovski/mini.nvim",
    priority = 1000,
    lazy = false,
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
    end,
    -- stylua: ignore
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
      clue = function()
        local miniclue = require "mini.clue"
        return {
          triggers = {
            { mode = "n", keys = "<Leader>" },
            { mode = "x", keys = "<Leader>" },

            { mode = "i", keys = "<C-x>" },

            { mode = "n", keys = "g" },
            { mode = "x", keys = "g" },

            { mode = "n", keys = "[" },
            { mode = "n", keys = "]" },

            { mode = "n", keys = "'" },
            { mode = "n", keys = "`" },
            { mode = "x", keys = "'" },
            { mode = "x", keys = "`" },

            { mode = "n", keys = '"' },
            { mode = "x", keys = '"' },
            { mode = "i", keys = "<C-r>" },
            { mode = "c", keys = "<C-r>" },

            { mode = "n", keys = "<C-w>" },

            { mode = "n", keys = "z" },
            { mode = "x", keys = "z" },
          },
          clues = {
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),
          },
        }
      end,
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
      surround = {
        mappings = {
          add = "gza",            -- Add surrounding in Normal and Visual modes
          delete = "gzd",         -- Delete surrounding
          find = "gzf",           -- Find surrounding (to the right)
          find_left = "gzF",      -- Find surrounding (to the left)
          highlight = "gzh",      -- Highlight surrounding
          replace = "gzr",        -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`
        },
      },
    },
  },
}
