require('config.lazy')
require('lualine').setup()
require('oil').setup()

-- map leader to space
vim.g.mapLeader = ' '

vim.o.relativenumber = true
vim.o.number = true


-- ###############################
-- ####    KEYMAP SETTINGS    ####
-- ###############################
vim.keymap.set('n', '<Leader>t', '<CMD>Oil --float<CR>', { desc = 'open oil in a floating window' })

-- maps for yanking to/pasting from the system register
vim.keymap.set('v', '<Leader>y', '"+y', { desc = 'yank into system register' })
vim.keymap.set('v', '<Leader>x', '"+x', { desc = 'cut into system register' })
vim.keymap.set({'n', 'v'}, '<Leader>p', '"+p', { desc = 'paste from system register' })

