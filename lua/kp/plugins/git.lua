return {
  {
    enabled = false,
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { mode = "n", "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
    },
    cmd = "Neogit",
    opts = {
      graph_style = "kitty",
    },
  },
}
