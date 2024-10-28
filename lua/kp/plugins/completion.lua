return {
  {
    "saghen/blink.cmp",
    event = { "LspAttach", "InsertCharPre" },
    version = "v0.*",
    opts = {
      highlight = {
        use_nvim_cmp_as_default = true,
      },
      nerd_font_variant = "mono",
      accept = { auto_brackets = { enabled = true } },
      trigger = { signature_help = { enabled = true } },
      keymap = {
        accept = "<CR>",
      },

      windows = {
        autocomplete = {
          border = "single",
        },
        documentation = {
          border = "single",
        },
      },
    },
  },
}
