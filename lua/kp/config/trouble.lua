local function config()
	local status_ok, trouble = pcall(require, "trouble")
	if not status_ok then
		return
	end

	trouble.setup({})
end

local function init(use)
	return use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("kp.config.trouble").config()
		end,
	})
end

return { init = init, config = config }
