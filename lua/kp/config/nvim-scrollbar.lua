local function config()
	local status_ok, scrollbar = pcall(require, "scrollbar")
	if not status_ok then
		return
	end

	local colors = require("tokyonight.colors").setup()

	scrollbar.setup({
		handle = {
			text = " ",
			color = colors.bg_highlight,
			hide_if_all_visible = false,
		},
		marks = {
			Search = { text = { "-", "■" }, priority = 0, color = colors.orange },
			Error = { text = { "-", "■" }, priority = 1, color = colors.error },
			Warn = { text = { "-", "■" }, priority = 2, color = colors.warning },
			Info = { text = { "-", "■" }, priority = 3, color = colors.info },
			Hint = { text = { "-", "■" }, priority = 4, color = colors.hint },
			Misc = { text = { "-", "■" }, priority = 5, color = colors.purple },
		},
		handlers = {
			diagnostic = true,
			search = true,
		},
	})

	-- require("hlslens").setup({
	-- 	---@diagnostic disable-next-line: unused-local
	-- 	build_position_cb = function(plist, bufnr, changedtick, pattern)
	-- 		require.search_handler.show(plist.start_pos)
	-- 	end,
	-- })
	-- vim.cmd([[
	--    augroup scrollbar_search_hide
	--      autocmd!
	--      autocmd CmdlineLeave : lua require('scrollbar').search_handler.hide()
	--    augroup END
	--  ]])
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
