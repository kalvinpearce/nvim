local map = require("settings.utils").map
local g = vim.g

g.wordmotion_mappings = {
    ['w'] = '<s-w>',
    ['b'] = '<s-b>',
    ['e'] = '<s-e>',
    ['ge'] = 'g<s-e>',
    ['aw'] = 'a<s-w>',
    ['iw'] = 'i<s-w>',
    ['<C-R><C-W>'] = '<C-R><s-w>'
}
