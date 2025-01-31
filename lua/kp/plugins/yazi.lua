return {
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "-",
        function()
          require("yazi").yazi()
        end,
        desc = "Open the file manager",
      },
      {
        -- Open in the current working directory
        "<leader>-",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open the file manager in nvim's working directory",
      },
    },
    ---@type YaziConfig
    opts = {
      open_for_directories = false,
    },
  },
}
