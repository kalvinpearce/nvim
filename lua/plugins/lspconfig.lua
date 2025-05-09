return {
  {
    "neovim/nvim-lspconfig",
    config = function(_, opts)
      for server, server_opts in pairs(opts.servers) do
        if server_opts then
          vim.lsp.config(server, server_opts)
        end
      end

      vim.lsp.enable({
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "eslint",
        "html",
        "jsonls",
        "lua_ls",
        "smithy_ls",
        "sourcekit",
        "svelte",
        "tailwindcss",
        "vtsls",
        "wgsl_analyzer",
        "yamlls",
      })
    end,
  },
}
