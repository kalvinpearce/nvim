local function config()
	local status_ok, cinnamon = pcall(require, "cinnamon")
	if not status_ok then
		return
	end

	cinnamon.setup({
		default_delay = 3
	})
end

local function init(use)
	return use({
		"declancm/cinnamon.nvim",
		config = function()
			require("kp.config.cinnamon").config()
		end,
	})
end

return { init = init, config = config }
