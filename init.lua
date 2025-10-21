require('config.lazy')
require('lualine').setup()
require('oil').setup()

-- map leader to space
vim.g.mapLeader = ' '

-- ##########################
-- ####   VIM OPTIONS    ####
-- ##########################
vim.o.relativenumber = true
vim.o.number = true

-- fold settings
vim.o.foldenable = true
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- ###############################
-- ####    KEYMAP SETTINGS    ####
-- ###############################
vim.keymap.set('n', '<Leader>t', '<CMD>Oil --float<CR>', { desc = 'open oil in a floating window' })

-- maps for yanking to/pasting from the system register
vim.keymap.set('v', '<Leader>y', '"+y', { desc = 'yank into system register' })
vim.keymap.set('v', '<Leader>x', '"+x', { desc = 'cut into system register' })
vim.keymap.set({'n', 'v'}, '<Leader>p', '"+p', { desc = 'paste from system register' })

-- fold keymap
vim.keymap.set('n', 'zz', 'za', { desc = 'toggle fold' })

-- auto-close keymaps
vim.keymap.set('i', '(<Tab>', '()<Left>')
vim.keymap.set('i', '[<Tab>', '[]<Left>')
vim.keymap.set('i', '{<Tab>', '{}<Left>')
vim.keymap.set('i', '\'<Tab>', '\'\'<Left>')
vim.keymap.set('i', '"<Tab>', '""<Left>')
vim.keymap.set('i', '{<CR>', '{<CR>}<ESC>O')
vim.keymap.set('i', '{;<CR>', '{<CR>};<ESC>O')

-- ########################################
-- ####    TOGGLETERM/LAZYGIT SETUP    ####
-- ########################################
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction='float' })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
