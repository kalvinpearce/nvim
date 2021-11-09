if vim.fn.has("win32") == 1 then
  require 'nvim-treesitter.install'.compilers = { "clang" }
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
