return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "ObsidianToday" },
    opts = {
      workspaces = {
        {
          name = "Brain",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain",
        },
      },
    },
  },
}
