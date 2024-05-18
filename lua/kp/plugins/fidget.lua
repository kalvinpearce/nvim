return {
  -- Progress display in bottom right of current lsp stats
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    tag = "legacy",
    config = function()
      require("fidget").setup()
    end,
  },
}
