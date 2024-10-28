return {
  {
    "Exafunction/codeium.vim",
    keys = {
      { mode = "i", "<M-left>", desc = "Codeium Trigger Suggestion" },
      { mode = "i", "<M-right>", desc = "Codeium Accept Suggestion" },
      { mode = "i", "<M-down>", desc = "Codeium Cycle Suggestions" },
      { mode = "i", "<M-up>", desc = "Codeium Cycle Suggestions" },
    },
    init = function()
      vim.g.codeium_disable_bindings = 1
      vim.g.codeium_manual = true
    end,
    config = function()
      vim.keymap.set("i", "<M-left>", function()
        return vim.fn["codeium#Complete"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<M-right>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<M-down>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<M-up>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
    end,
  },
}
