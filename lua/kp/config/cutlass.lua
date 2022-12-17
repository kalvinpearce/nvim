local function config()
	local status_ok, cutlass = pcall(require, "cutlass")
	if not status_ok then
		return
	end

	cutlass.setup({
		cut_key = "m"
	})
end

local function init(use)
	return use({
		"gbprod/cutlass.nvim",
		config = function()
			require("kp.config.cutlass").config()
		end,
	})
end

return { init = init, config = config }
