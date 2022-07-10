local tbl_extend = vim.tbl_extend

local function map(mode, key, result, opts)
	opts = tbl_extend("keep", opts or {}, {
		noremap = true,
		silent = true,
	})
	vim.keymap.set(mode, key, result, opts)
end

return { map = map }
