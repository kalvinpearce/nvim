return {
  {
    "j-morano/buffer_manager.nvim",
    keys = {
      {
        "<leader>bb",
        function()
          require("buffer_manager.ui").toggle_quick_menu()
        end,
        desc = "Open buffer list"
      },
    }
  }
}
