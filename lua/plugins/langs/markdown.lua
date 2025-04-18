return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_command_for_global = 1
      vim.g.mkdp_combine_preview = 1

      ---Fixes "No command :MarkdownPreview"
      ---https://github.com/iamcco/markdown-preview.nvim/issues/585#issuecomment-1724859362
      local function load_then_exec(cmd)
        return function()
          vim.cmd.delcommand(cmd)
          require("lazy").load { plugins = { "markdown-preview.nvim" } }
          vim.api.nvim_exec_autocmds("BufEnter", {}) -- commands appear only after BufEnter
          vim.cmd(cmd)
        end
      end
      for _, cmd in pairs { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" } do
        vim.api.nvim_create_user_command(cmd, load_then_exec(cmd), {})
      end
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
