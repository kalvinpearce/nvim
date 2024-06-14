return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "frappe", -- latte, frappe, macchiato, mocha
        integrations = {
          lsp_trouble = true,
          mason = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          notify = true,
          semantic_tokens = true,
          telescope = true,
          which_key = true,
        },
      }
      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
