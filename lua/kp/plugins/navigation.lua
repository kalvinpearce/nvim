return {
  -- Navigate your code with search labels, enhanced character motions, and Treesitter
  {
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "harpoon2",
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup()

      vim.keymap.set("n", "<m-m><m-m>", function()
        harpoon:list():add()
      end, { desc = "Add file" })
      vim.keymap.set("n", "<m-m><m-l>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Quick menu" })

      -- Set <m-1>..<m-5> be my shortcuts to moving to the files
      -- fucked symbols cause macos right alt???
      for index, idx in ipairs { "¡", "™", "£", "¢", "∞" } do
        vim.keymap.set("n", idx, function()
          harpoon:list():select(index)
        end, { desc = "Nav file " .. index })
        vim.keymap.set("n", string.format("<space>%d", index), function()
          harpoon:list():select(index)
        end, { desc = "Nav file " .. index })
      end
    end,
  },
}
