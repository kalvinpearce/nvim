return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup {
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      }

      ---@diagnostic disable-next-line: duplicate-set-field
      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "JK", [[<C-\><C-n>]], opts)
      end

      vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new { cmd = "lazygit", hidden = true, direction = "tab" }

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      local map = require("kp.utils").map
      map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float" })
      map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Horizontal" })
      map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Vertical" })

      map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })
    end,
  },
}
