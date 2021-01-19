local fn = vim.fn
local cmd = vim.cmd
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
    fn.nvim_set_keymap(mode, key, result, opts)
end

function U.apply_options(opts)
    for k, v in pairs(opts) do
        if v == true then
            cmd("set " .. k)
        elseif v == false then
            cmd(string.format("set no%s", k))
        else
            cmd(string.format("set %s=%s", k, v))
        end
    end
end

return U
