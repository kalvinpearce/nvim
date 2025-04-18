return {
  -- Juiced rust crates support in cargo.toml
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},
        -- LSP configuration
        server = {
          on_attach = function(_client, bufnr)
            vim.keymap.set("n", "<leader>la", function()
              vim.cmd.RustLsp("codeAction")
            end, { desc = "Code Action", buffer = bufnr })

            vim.keymap.set(
              "n",
              "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
              function()
                vim.cmd.RustLsp({ "hover", "actions" })
              end,
              { silent = true, buffer = bufnr }
            )
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              inlayHints = {
                typeHints = { enable = false },
                parameterHints = { enable = false },
              },
              cargo = {
                features = "all",
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Add clippy lints for Rust.
              checkOnSave = {
                features = "all",
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              diagnostics = {
                disabled = { "inactive-code", "proc-macro-disabled" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                  ["leptos_macro"] = { "server" },
                  ["tokio"] = { "test" },
                  ["tokio-macros"] = { "test" },
                  ["test_log"] = { "test" },
                  ["test_log_macros"] = { "test" },
                },
              },
            },
          },
        },
      }
    end,
  },
}
