local cmd = vim.cmd
local U = {}

function U.apply_options(opts)
    for k, v in pairs(opts) do
        if v == true then
            cmd("set " .. k)
        elseif v == false then
            cmd(string.format("set no%", k))
        else
            cmd(string.format("set %s=%s", k, v))
        end
    end
end