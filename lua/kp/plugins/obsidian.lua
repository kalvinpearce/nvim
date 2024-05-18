return {
  "epwalsh/obsidian.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Brain",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain",
      },
    },
  },
}
