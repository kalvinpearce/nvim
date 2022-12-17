local function config()
	local status_ok, scrollbar = pcall(require, "scrollbar")
	if not status_ok then
		return
	end

	scrollbar.setup({
		handle = {
			text = " ",
			hide_if_all_visible = false,
		},
		marks = {
			Search = { text = { "-", "■" }, priority = 0 },
			Error = { text = { "-", "■" }, priority = 1 },
			Warn = { text = { "-", "■" }, priority = 2 },
			Info = { text = { "-", "■" }, priority = 3 },
			Hint = { text = { "-", "■" }, priority = 4 },
			Misc = { text = { "-", "■" }, priority = 5 },
		},
		handlers = {
			diagnostic = true,
			search = true,
		},
		excluded_buftypes = {
			"terminal",
		},
		excluded_filetypes = {
			"prompt",
			"TelescopePrompt",
		},
	})
	require("scrollbar.handlers.search").setup()
end

local function init(use)
	return use({
		"petertriho/nvim-scrollbar",
		requires = "kevinhwang91/nvim-hlslens",
		config = function()
			require("kp.config.nvim-scrollbar").config()
		end,
	})
end

return { init = init, config = config }
