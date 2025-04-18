return {
  -- Smarter and more intuitive split pane management
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      local map = vim.keymap.set

      map("n", "<A-h>", require("smart-splits").resize_left)
      map("n", "<A-j>", require("smart-splits").resize_down)
      map("n", "<A-k>", require("smart-splits").resize_up)
      map("n", "<A-l>", require("smart-splits").resize_right)
      -- moving between splits
      map("n", "<C-h>", require("smart-splits").move_cursor_left)
      map("n", "<C-j>", require("smart-splits").move_cursor_down)
      map("n", "<C-k>", require("smart-splits").move_cursor_up)
      map("n", "<C-l>", require("smart-splits").move_cursor_right)
      map("n", "<C-\\>", require("smart-splits").move_cursor_previous)
      -- swapping buffers between windows
      map("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
      map("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
      map("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
      map("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
    end,
  },
}
