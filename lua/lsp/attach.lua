local util = require('lspconfig').util

-- function to attach completion when setting up lsp
local on_attach = function(client)
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