-- Plugin manager - lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
    print('Installing lazy.nvim....')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
    print('Done.')
end

vim.opt.rtp:prepend(lazypath)

-- plugins
require('lazy').setup({
    {'catppuccin/nvim', name = "catppuccin", priority = 1000 },
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'junegunn/fzf'},
    {'junegunn/fzf.vim'},

    -- LSP Support
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
        }
    },
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {'L3MON4D3/LuaSnip'}
        },
    },
})

-- settings
vim.cmd([[
set scrolloff=8
set number
set relativenumber 
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set expandtab
set termguicolors
filetype plugin on
syntax on

colorscheme catppuccin-macchiato 

let mapleader = " "
nnoremap <leader>p :Vex<CR>
nnoremap <leader>gp :GFiles<CR>
nnoremap <leader>fp :Files<CR>
nnoremap <C-p> :GFiles<CR>
]])

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        lsp_zero.default_setup,
    },
})
