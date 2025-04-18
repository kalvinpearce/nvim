return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme "catppuccin"
    end,
    opts = {
      flavour = "frappe", -- latte, frappe, macchiato, mocha
      compile = true,
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        mason = true,
        notify = true,
      },
    },
  },
}
