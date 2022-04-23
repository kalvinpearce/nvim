local function config()
	vim.g.tokyonight_style = "storm"
	vim.g.tokyonight_italic_functions = true
	local colorscheme = "tokyonight"
	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
	if not status_ok then
		vim.notify("colorscheme " .. colorscheme .. " not found!")
		return
	end
end

local function init(use)
	return use({
		"folke/tokyonight.nvim",
		config = function()
			require("kp.config.tokyonight").config()
		end,
	})
end

return { init = init, config = config }
