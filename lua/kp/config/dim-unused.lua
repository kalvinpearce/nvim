local function config()
	local status_ok, dim = pcall(require, "dim")
	if not status_ok then
		return
	end

	dim.setup({})
end

local function init(use)
	return use({
		"narutoxy/dim.lua",
		config = function()
			require("kp.config.dim-unused").config()
		end,
	})
end

return { init = init, config = config }
