local function config()
	local status_ok, surround = pcall(require, "nvim-surround")
	if not status_ok then
		return
	end
	surround.setup({})
end

local function init(use)
	return use({
		"kylechui/nvim-surround",
		config = function()
			require("kp.config.surround").config()
		end,
	})
end

return { init = init, config = config }
