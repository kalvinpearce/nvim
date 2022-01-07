local function config()
	-- do setup stuff here
end

local function init(use)
	return use({
		"username/plugin-name",
		config = function()
			require("config.plugin-name").config()
		end,
	})
end

return { init = init, config = config }
