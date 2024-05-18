return {
  {
    enabled = false,
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
          accept = "<M-right>",
          accept_word = "<M-left>",
          accept_line = false,
          next = "<M-up>",
          prev = "<M-down>",
          dismiss = "<M-e>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        help = true,
        markdown = true,
        yaml = true,
      },
    },
  },
}
