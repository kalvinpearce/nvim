local lsp = vim.lsp

lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler