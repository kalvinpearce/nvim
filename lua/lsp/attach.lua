local util = require('lspconfig').util
local map = require("settings.utils").map

-- function to attach completion when setting up lsp
local on_attach = function(client)
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

    require'completion'.on_attach()
    if client.resolved_capabilities.document_formatting then
        util.nvim_multiline_command [[
            augroup lsp_format_on_save
                autocmd!
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
            augroup END
        ]]
    elseif client.resolved_capabilities.document_range_formatting then
        util.nvim_multiline_command [[
            augroup lsp_format_on_save
                autocmd!
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
            augroup END
        ]]
    end

    if client.resolved_capabilities.document_highlight then
        util.nvim_multiline_command [[
            :hi LspReferenceRead cterm=bold ctermbg=red guibg=Grey guifg=Black
            :hi LspReferenceText cterm=bold ctermbg=red guibg=Grey guifg=Black
            :hi LspReferenceWrite cterm=bold ctermbg=red guibg=Grey guifg=Black
            augroup lsp_document_highlight
                autocmd!
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]]
    end
end

return { on_attach }