local function config()
  local status_ok, notify = pcall(require, "notify")
  if not status_ok then
    return
  end
  vim.notify = notify
end

local function init(use)
	return use({
		"rcarriga/nvim-notify",
		config = function()
			require("kp.config.nvim-notify").config()
		end,
	})
end

return { init = init, config = config }
