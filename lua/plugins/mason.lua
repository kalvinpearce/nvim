return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts = {},
  init = function()
    -- Make mason packages available before loading it; allows to lazy-load mason.
    vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
    -- Do not crowd home directory with NPM cache folder
    vim.env.npm_config_cache = vim.env.HOME .. "/.cache/npm"
  end,
}
