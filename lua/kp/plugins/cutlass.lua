return {
  -- Cutlass overrides the delete operations to actually just delete and not affect the current yank
  {
    "gbprod/cutlass.nvim",
    config = function()
      require("cutlass").setup({ cut_key = "m" })
    end,
  },
}
