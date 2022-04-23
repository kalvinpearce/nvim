local function config()
	local status_ok, tabline = pcall(require, "tabline")
	if not status_ok then
		return
	end

	tabline.setup({
		-- Defaults configuration options
		enable = true,
		options = {
			max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
			show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
			show_devicons = true, -- this shows devicons in buffer section
			show_bufnr = false, -- this appends [bufnr] to buffer section,
			show_filename_only = false, -- shows base filename only instead of relative path in filename
			-- modified_icon = "+ ", -- change the default modified icon
			-- modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
		},
	})
	vim.cmd([[
    set guioptions-=e " Use showtabline in gui vim
    set sessionoptions+=tabpages,globals " store tabpages and globals in session
  ]])
end

local function init(use)
	return use({
		"kdheepak/tabline.nvim",
		config = function()
			require("kp.config.tabline-nvim").config()
		end,
	})
end

return { init = init, config = config }
