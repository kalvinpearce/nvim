local function config()
	-- local status_ok, PLUGIN_NAME = pcall(require, "PLUGIN_NAME")
	-- if not status_ok then
	-- 	return
	-- end
end

local function init(use)
	return use({
		"username/plugin-name",
		config = function()
			require("kp.config.plugin-name").config()
		end,
	})
end

return { init = init, config = config }
