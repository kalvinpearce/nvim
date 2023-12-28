local M = {}

vim.list_extend(M, require("kp.plugins.lsp.lspconfig"))
vim.list_extend(M, require("kp.plugins.lsp.null-ls"))
vim.list_extend(M, require("kp.plugins.lsp.mason"))

-- vim.list_extend(M, require("kp.plugins.lsp.lang.csharp"))
vim.list_extend(M, require("kp.plugins.lsp.lang.json"))
vim.list_extend(M, require("kp.plugins.lsp.lang.rust"))
vim.list_extend(M, require("kp.plugins.lsp.lang.tailwind"))
vim.list_extend(M, require("kp.plugins.lsp.lang.typescript"))

return M
