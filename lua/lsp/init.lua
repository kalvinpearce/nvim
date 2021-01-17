local map = require("settings.utils").map

require("lsp.lsputils")
require("lsp.diagnostics")
require("lsp.treesitter")

require("lsp.vim")
require("lsp.rust")

-- LSP
map("n", 'K', "<Cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "gdt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
map("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
map("n", "]d", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")