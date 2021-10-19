require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "c_sharp" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
