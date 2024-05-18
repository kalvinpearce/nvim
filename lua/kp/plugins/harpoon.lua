return {
  -- Quick file navigation: harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>hg", function() harpoon:list():append() end, { desc = "Add file" })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = "Quick menu" })

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():select(1) end, { desc = "Nav file 1" })
      vim.keymap.set("n", "<leader>hs", function() harpoon:list():select(2) end, { desc = "Nav file 2" })
      vim.keymap.set("n", "<leader>hd", function() harpoon:list():select(3) end, { desc = "Nav file 3" })
      vim.keymap.set("n", "<leader>hf", function() harpoon:list():select(4) end, { desc = "Nav file 4" })
    end,
  },
}
