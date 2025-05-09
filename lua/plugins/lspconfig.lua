return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("*", {})
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
}
