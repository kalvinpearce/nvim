local function config()
	vim.g.firenvim_config = {
		globalSettings = { alt = "all" },
		localSettings = {
			[".*"] = {
				cmdline = "neovim",
				content = "text",
				priority = 0,
				selector = "textarea",
				takeover = "always",
			},
		},
	}
end

local function init(use)
	return use({
		"glacambre/firenvim",
		config = function()
			require("kp.config.firenvim").config()
		end,
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})
end

return { init = init, config = config }
