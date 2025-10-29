require('config.lazy')
require('lualine').setup()
require('oil').setup()
require('autoclose').setup()
-- https://github.com/folke/noice.nvim
require("noice").setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    routes = {
        {
            filter = {event = "msg_show", any = {{find = "%d+L, %d+B"}}},
            view = "mini"
        }, {
            filter = {
                event = "msg_show",
                any = {
                    {find = "; after #%d+"}, {find = "; before #%d+"},
                    {find = "more lines"}, {find = "fewer lines"},
                    {find = "search hit BOTTOM"}, {find = "pick_window"},
                    {find = "fargs"}
                }
            },
            opts = {skip = true}
        }
    }
})

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
vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'

-- tabbing settings
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = false
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

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

-- fzf keymap
-- source: https://github.com/junegunn/fzf.vim
vim.keymap.set('n', '<Leader>f', '<cmd>Files<CR>', { desc = 'list files' })
vim.keymap.set('n', '<Leader>b', '<cmd>Buffers<CR>', { desc = 'list files' })

-- #####################################
-- ####    LANGUAGE SERVER SETUP    ####
-- #####################################

-- integrate language server with nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

local function setupLsp(name)
    lspconfig[name].setup { capabilities = capabilities }
end

-- https://github.com/neovim/nvim-lspconfig/tree/master
local lsps = {
    'lua_ls',
    'rust_analyzer',
    'jdtls',
    -- 'kotlin_lsp', -- TODO doesn't work for some reason
    'gradle_ls',
    'sqlls',
    'ts_ls',
    'bashls',
}
require('mason-lspconfig').setup({
    automatic_enable = false,
    ensure_installed = lsps,
})
for _, lsp in ipairs(lsps) do
    setupLsp(lsp)
end

vim.diagnostic.config({
    update_in_insert = true,
    virtual_text = true, -- less verbose
    -- virtual_lines = true,
    severity_sort = true,
})

-- ########################################
-- ####    TOGGLETERM/LAZYGIT SETUP    ####
-- ########################################
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction='float' })

function Lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua Lazygit_toggle()<CR>", {noremap = true, silent = true})

