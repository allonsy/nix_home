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
local telescope_builtin = require('telescope.builtin')

-- telescope keymaps
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })

-- lsp keymaps
vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, { desc = 'Goto Definition' })
vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, { desc = 'Goto References' })
vim.keymap.set('n', 'gt', telescope_builtin.lsp_type_definitions, { desc = 'Goto Type Definitions' })

-- harpoon
local harpoon = require('harpoon')
harpoon.setup()

vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'Harpoon add file' })
vim.keymap.set('n', '<leader>hh', function() harpoon:list():select(1) end, { desc = 'Harpoon select(1)' })

local telescope_conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = telescope_conf.file_previewer({}),
    sorter = telescope_conf.generic_sorter({}),
  }):find()
end

vim.keymap.set("n", "<leader>hf", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })

-- tree-sitter
require('tree-sitter-conf')

-- lsps
require('lsp-conf')
