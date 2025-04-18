return {
  {
    "saghen/blink.cmp",
    event = { "InsertEnter" },
    version = "v0.*",
    opts = {
      cmdline = {
        keymap = {
          ["<down>"] = { "select_next", "fallback" },
          ["<up>"] = { "select_prev", "fallback" },
          ["<Esc>"] = { "cancel", "fallback" },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = {
        enabled = true,
        window = { border = "single" },
      },

      keymap = { preset = "enter" },

      completion = {
        accept = { auto_brackets = { enabled = false } },
        menu = {
          border = "single",
          draw = {
            treesitter = { "lsp" },
          },
          auto_show = function(ctx)
            -- Don't show completion menu automatically when searching
            return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
          end,
        },
        list = {
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
          },
        },
        documentation = {
          window = { border = "single" },
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
        trigger = {
          show_on_insert_on_trigger_character = false,
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
