local api = vim.api
local tbl_extend = vim.tbl_extend
local U = {}

function U.map(mode, key, result, opts)
    opts = tbl_extend(
        "keep",
        opts or {},
        {
            noremap = true,
            silent = true,
            expr = false
        }
    )
    api.nvim_set_keymap(mode, key, result, opts)
end

return U
