local jj = require('jj')
vim.keymap.set('n', '<leader>jj', jj.status_open)
vim.keymap.set('n', '<leader>jf', ':!jj git fetch<CR>')
vim.keymap.set('n', '<leader>js', ':!jj rebase -d \'trunk()\'<CR>')
