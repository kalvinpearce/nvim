local function config()
	local status_ok, session_manager = pcall(require, "session_manager")
	if not status_ok then
		return
	end
	local Path = require("plenary.path")
	session_manager.setup({
		sessions_dir = Path:new(vim.fn.stdpath("data"), "session"), -- The directory where the session files will be saved.
		path_replacer = "__", -- The character to which the path separator will be replaced for session files.
		colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
		autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
		autosave_last_session = true, -- Automatically save last session on exit.
		autosave_ignore_not_normal = true, -- Plugin will not save a session when no writable and listed buffers are opened.
	})
end

local function init(use)
	return use({
		"Shatur/neovim-session-manager",
		config = function()
			require("config.session-manager").config()
		end,
	})
end

return { init = init, config = config }
