return {
  {
    "Exafunction/windsurf.nvim",
    build = ":Codeium Auth",
    keys = {
      {
        mode = "i",
        "<M-left>",
        function()
          require("codeium.virtual_text").cycle_or_complete()
        end,
        desc = "Windowsurf Trigger Suggestion",
      },
    },
    opts = {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        manual = true,
        key_bindings = {
          accept = "<M-right>",
        },
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      require("codeium").setup(opts)
    end,
  },
}
