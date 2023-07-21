return {
  -- Quick file navigation: harpoon
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "<a-n>",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Add file",
      },
      {
        "<a-h>",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Quick menu",
      },
      {
        "<a-u>",
        function()
          require("harpoon.cmd-ui").toggle_quick_menu()
        end,
        desc = "Quick menu",
      },
      {
        "<a-j>",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Nav file 1",
      },
      {
        "<a-k>",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Nav file 2",
      },
      {
        "<a-l>",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Nav file 3",
      },
      {
        "<a-;>",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        desc = "Nav file 4",
      },
    },
    config = true,
  },
}
