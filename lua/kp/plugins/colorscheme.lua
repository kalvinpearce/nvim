return {
  {
    "uloco/bluloco.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = true,
    config = function()
      -- vim.cmd([[colorscheme bluloco]])
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = { style = "storm" },
    lazy = true,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin-frappe]])
    end,
  },
}
