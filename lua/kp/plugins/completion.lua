return {
  {
    "saghen/blink.cmp",
    event = { "InsertEnter" },
    version = "v0.*",
    opts = {
      keymap = { preset = "enter" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true },

      completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = {
          border = "single",
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
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
