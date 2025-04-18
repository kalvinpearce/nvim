return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
            },
            {
              "diagnostics",
              symbols = {
                error = " ",
                warn = " ",
                hint = " ",
                info = " ",
              },
            },
          },
          lualine_c = {
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = { left = 2, right = 0 },
            },
            {
              "filename",
              path = 1,
              symbols = { modified = "  ", readonly = "  ", unnamed = "  " },
            },
          },
          lualine_x = { "encoding" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      }
    end,
  },
}
