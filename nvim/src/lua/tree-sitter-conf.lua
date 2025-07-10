local tree_sitter = require('nvim-treesitter')
tree_sitter.setup {
  install_dir = vim.fn.stdpath('config') .. '/languages'
}
