return {
  -- Navigate your code with search labels, enhanced character motions, and Treesitter
  {
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    },
  },
}
