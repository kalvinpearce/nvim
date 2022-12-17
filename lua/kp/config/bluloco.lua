local function config()
	local colorscheme = "bluloco"
	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
	if not status_ok then
		vim.notify("colorscheme " .. colorscheme .. " not found!")
		return
	end
end

local function init(use)
	return use({
		"uloco/bluloco.nvim",
		requires = { "rktjmp/lush.nvim" },
		config = function()
			require("kp.config.bluloco").config()
		end,
	})
end

return { init = init, config = config }
