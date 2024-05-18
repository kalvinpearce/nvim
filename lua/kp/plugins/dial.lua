return {
  -- Enhanced increment/decrement plugin
  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.constant.alias.bool, -- boolean value (true <-> false)
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
        },
      })

      local map = require("kp.utils").map
      local dialMap = require("dial.map")
      map("n", "<C-a>", dialMap.inc_normal())
      map("n", "<C-x>", dialMap.dec_normal())
      map("v", "<C-a>", dialMap.inc_visual())
      map("v", "<C-x>", dialMap.dec_visual())
      map("v", "g<C-a>", dialMap.inc_gvisual())
      map("v", "g<C-x>", dialMap.dec_gvisual())
    end,
  },
}
