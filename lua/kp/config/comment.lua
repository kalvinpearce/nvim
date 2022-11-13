local function config()
	local status_ok, comment = pcall(require, "Comment")
	if not status_ok then
		return
	end

	comment.setup({
		mappings = {
			basic = true,
			extra = true,
		},
		pre_hook = function(ctx)
			if vim.bo.filetype == "typescriptreact" then
				local U = require("Comment.utils")
				local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
				local location = nil
				if ctx.ctype == U.ctype.block then
					location = require("ts_context_commentstring.utils").get_cursor_location()
				elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
					location = require("ts_context_commentstring.utils").get_visual_start_location()
				end
				return require("ts_context_commentstring.internal").calculate_commentstring({
					key = type,
					location = location,
				})
			end
		end,
	})
end

local function init(use)
	return use({
		"numToStr/Comment.nvim",
		config = function()
			require("kp.config.comment").config()
		end,
	})
end

return { init = init, config = config }
