return {
  {
    "Exafunction/codeium.vim",
    keys = {
      {
        mode = "i",
        "<M-left>",
        function()
          return vim.fn["codeium#Complete"]()
        end,
        desc = "Codeium Trigger Suggestion",
      },
      {
        mode = "i",
        "<M-right>",
        function()
          return vim.fn["codeium#Accept"]()
        end,
        desc = "Codeium Accept Suggestion",
      },
      {
        mode = "i",
        "<M-down>",
        function()
          return vim.fn["codeium#CycleCompletions"](1)
        end,
        desc = "Codeium Cycle Suggestions",
      },
      {
        mode = "i",
        "<M-up>",
        function()
          return vim.fn["codeium#CycleCompletions"](-1)
        end,
        desc = "Codeium Cycle Suggestions",
      },
    },
    init = function()
      vim.g.codeium_disable_bindings = 1
      vim.g.codeium_manual = true
    end,
  },
}
