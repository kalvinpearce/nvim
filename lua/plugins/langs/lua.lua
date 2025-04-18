return {
  {
    "folke/lazydev.nvim",
    priority = 100,
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "lazy.nvim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "wezterm-types", mods = { "wezterm" } },
      },
      integrations = {
        lspconfig = false,
      },
    },
  },

  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "folke/lazydev.nvim" },
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
  },
}
