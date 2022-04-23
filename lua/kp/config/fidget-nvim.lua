local function config()
	local status_ok, fidget = pcall(require, "fidget")
	if not status_ok then
		return
	end
	fidget.setup({})
end

local function init(use)
	return use({
		"j-hui/fidget.nvim",
		config = function()
			require("kp.config.fidget-nvim").config()
		end,
	})
end

return { init = init, config = config }
