local function config()
	local status_ok, neodim = pcall(require, "neodim")
	if not status_ok then
		return
	end

	neodim.setup({
		alpha = 0.75,
		blend_color = "#000000",
		update_in_insert = {
			enable = true,
			delay = 100,
		},
		hide = {
			virtual_text = false,
			signs = true,
			underline = true,
		},
	})
end

local function init(use)
	return use({
		"zbirenbaum/neodim",
		event = "LspAttach",
		config = function()
			require("kp.config.dim-unused").config()
		end,
	})
end

return { init = init, config = config }
