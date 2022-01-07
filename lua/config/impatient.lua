local function config()
	local status_ok, impatient = pcall(require, "impatient")
	if not status_ok then
		return
	end

	impatient.enable_profile()
end

local function init(use)
	return use({
		"lewis6991/impatient.nvim",
		config = function()
			require("config.impatient").config()
		end,
	})
end

return { init = init, config = config }
