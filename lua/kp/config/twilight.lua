local function config()
	local status_ok, twilight = pcall(require, "twilight")
	if not status_ok then
		return
	end
	twilight.setup({})
end

local function init(use)
	return use({
		"folke/twilight.nvim",
		cmd = { "TwilightEnable", "Twilight" },
		config = function()
			require("kp.config.twilight").config()
		end,
	})
end

return { init = init, config = config }
