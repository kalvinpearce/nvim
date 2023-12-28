return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-right>",
          accept_word = "<M-left>",
          accept_line = false,
          next = "<M-up>",
          prev = "<M-down>",
          dismiss = "<M-e>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        help = true,
        markdown = true,
        yaml = true,
      },
    },
  },

  -- Add copilot status to lualine
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     local utils = require("kp.utils")
  --     local colors = {
  --       [""] = utils.fg("Special"),
  --       ["Normal"] = utils.fg("Special"),
  --       ["Warning"] = utils.fg("DiagnosticError"),
  --       ["InProgress"] = utils.fg("DiagnosticWarn"),
  --     }
  --     print(vim.inspect(opts))

  --     table.insert(opts.sections.lualine_x, 1, {
  --       function()
  --         local icon = require("lazyvim.config").icons.kinds.Copilot
  --         local status = require("copilot.api").status.data
  --         return icon .. (status.message or "")
  --       end,
  --       cond = function()
  --         local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
  --         return ok and #clients > 0
  --       end,
  --       color = function()
  --         if not package.loaded["copilot"] then
  --           return
  --         end
  --         local status = require("copilot.api").status.data
  --         return colors[status.status] or colors[""]
  --       end,
  --     })
  --   end,
  -- },

  -- Copilot cmp source
  -- {
  --   "nvim-cmp",
  --   dependencies = {
  --     {
  --       "zbirenbaum/copilot-cmp",
  --       dependencies = "copilot.lua",
  --       opts = {},
  --       config = function(_, opts)
  --         local copilot_cmp = require("copilot_cmp")
  --         copilot_cmp.setup(opts)
  --         -- attach cmp source whenever copilot attaches
  --         -- fixes lazy-loading issues with the copilot cmp source
  --         require("kp.utils").on_attach(function(client)
  --           if client.name == "copilot" then
  --             copilot_cmp._on_insert_enter({})
  --           end
  --         end)
  --       end,
  --     },
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     table.insert(opts.sources, 1, { name = "copilot", group_index = 2 })
  --     opts.sorting = opts.sorting or require("cmp.config.default")().sorting
  --     table.insert(opts.sorting.comparators, 1, require("copilot_cmp.comparators").prioritize)
  --   end,
  -- },
}
