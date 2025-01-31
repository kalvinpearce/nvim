local function fzf(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = vim.uv.cwd() }, opts or {})
    require("fzf-lua")[builtin](opts)
  end
end

return {
  {
    "ibhagwan/fzf-lua",
    enabled = false,
    cmd = "FzfLua",
    opts = {
      "default-title",
    },
    keys = {
      { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
      { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
      {
        "<leader>,",
        "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>/", fzf "live_grep", desc = "Grep (Root Dir)" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      -- find
      { "<leader>bb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<c-p>", "<cmd>FzfLua files<cr>", desc = "Find Files (Root Dir)" },
      { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { "<leader>fs", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
      { "<leader>fR", fzf("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      -- git
      { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
      -- search
      { '<leader>f"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>fa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      { "<leader>fb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
      { "<leader>fc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>fC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>fd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
      { "<leader>fD", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
      -- { "<leader>fg", fzf "live_grep", desc = "Grep (Root Dir)" },
      { "<leader>fG", fzf("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>fH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
      { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>fl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
      { "<leader>fM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { "<leader>fR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { "<leader>fq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
      { "<leader>fw", fzf "grep_cword", desc = "Word (Root Dir)" },
      { "<leader>fW", fzf("grep_cword", { root = false }), desc = "Word (cwd)" },
      {
        "<leader>fw",
        fzf "grep_visual",
        mode = "v",
        desc = "Selection (Root Dir)",
      },
      {
        "<leader>fW",
        fzf("grep_visual", { root = false }),
        mode = "v",
        desc = "Selection (cwd)",
      },
      { "<leader>uC", fzf "colorschemes", desc = "Colorscheme with Preview" },
    },
  },
}
