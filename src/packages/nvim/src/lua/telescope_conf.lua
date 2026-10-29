local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')

local hidden_args = { '--hidden', '--glob', '!**/.git/*', '--glob', '!**/.jj/*' }

telescope.setup({
  pickers = {
    find_files = {
      find_command = vim.list_extend({ 'rg', '--files', '--color', 'never' }, hidden_args),
    },
    live_grep = {
      additional_args = hidden_args,
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_cursor({ initial_mode = 'normal' }),
    },
  },
})

-- route vim.ui.select (used by vim.lsp.buf.code_action) through telescope
telescope.load_extension('ui-select')

-- telescope keymaps
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })
