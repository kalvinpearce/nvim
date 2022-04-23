local function config()
  local status_ok, todo = pcall(require, "todo-comments")
  if not status_ok then
    return
  end
  todo.setup({})
end

local function init(use)
	return use({
		"folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
		config = function()
			require("kp.config.todo").config()
		end,
	})
end

return { init = init, config = config }
