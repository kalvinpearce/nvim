local function config()
	local status_ok, project = pcall(require, "project_nvim")
	if not status_ok then
		return
	end

	project.setup({
		detection_methods = { "pattern", "lsp" },
		patterns = { ".git", "package.json", "cargo.toml" },
	})

	require("telescope").load_extension("projects")
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
