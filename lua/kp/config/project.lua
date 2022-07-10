local function config()
	local status_ok, project = pcall(require, "project_nvim")
	if not status_ok then
		return
	end

	project.setup({
		patterns = { ".git", "package.json", "cargo.toml" },
	})
end

local function init(use)
	return use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("kp.config.project").config()
		end,
	})
end

return { init = init, config = config }
