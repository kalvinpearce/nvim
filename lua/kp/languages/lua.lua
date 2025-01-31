return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            "lazy.nvim",
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "wezterm-types", mods = { "wezterm" } },
          },
        },
      },
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = {
                  "Snacks",
                },
              },
            },
          },
        },
      },
    },
  },
}
