return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>lf",
      function()
        require("conform").format { async = true, lsp_fallback = true }
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      sql = { "sqlfluff", "sql_formatter", "sqlfmt", stop_after_first = true },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
    },
    -- Set up format-on-save
    format_on_save = function(bufnr)
      -- Disable autoformat on certain filetypes
      local ignore_filetypes = { "sql" }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
      end

      -- Disable with a global or buffer-local variable
      if vim.g.disable_format_on_save or vim.b[bufnr].disable_format_on_save then
        return
      end

      -- Disable autoformat for Cargo.toml file
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match "Cargo.toml" then
        return
      end

      return { timeout_ms = 500, lsp_fallback = true }
    end,
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      sqlfluff = {
        args = { "fix", "--force", "-" },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.keymap.set("n", "<leader>uf", function()
      ---@diagnostic disable-next-line: inject-field
      vim.b.disable_format_on_save = not vim.b.disable_format_on_save
      vim.notify("Format on save: " .. (vim.b.disable_format_on_save and "disabled" or "enabled"))
    end, { desc = "Toggle format on save" })
  end,
}
