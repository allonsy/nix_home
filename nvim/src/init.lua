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
vim.o.timeoutlen = 300

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


-- tree-sitter
require('tree-sitter-conf')

-- lsps
require('lsp-conf')
