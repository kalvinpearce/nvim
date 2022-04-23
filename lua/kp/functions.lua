local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader
if not ok then
	reloader = require
else
	reloader = plenary_reload.reload_module
end

P = function(v)
	print(vim.inspect(v))
	return v
end

RELOAD = function(...)
	return reloader(...)
end

R = function(name)
	RELOAD(name)
	return require(name)
end

FULL_RELOAD = function()
	for name, _ in pairs(package.loaded) do
		if name:match("^kp") then
			package.loaded[name] = nil
		end
	end
	require("kp.init")
  print("Conifg Reloaded")
end
vim.api.nvim_create_user_command("ReloadConfig", FULL_RELOAD, {})
