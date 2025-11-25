-- map leaders
-- must be first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.packpath:prepend(vim.fn.stdpath("config") .. "/plugins")

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.showmode = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 500

vim.o.splitright = true
vim.o.splitbelow = true

-- whitespace markers
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- line marker
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 5

vim.o.confirm = true


-- keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- telescope
require('telescope_conf')
local telescope_builtin = require('telescope.builtin')

-- lsp keymaps
vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, { desc = 'Goto Definition' })
vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, { desc = 'Goto References' })
vim.keymap.set('n', 'gt', telescope_builtin.lsp_type_definitions, { desc = 'Goto Type Definitions' })
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = 'Goto Code Actions' })

-- harpoon
require('harpoon_conf')

-- tree-sitter
require('tree-sitter-conf')

-- lsps
require('lsp-conf')
