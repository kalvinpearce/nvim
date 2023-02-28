return {
    -- Juiced rust crates support in cargo.toml
    {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = { "BufRead Cargo.toml" },
        config = function()
            require('crates').setup({
                null_ls = {
                    enabled = true,
                },
            })
        end,
    }
}