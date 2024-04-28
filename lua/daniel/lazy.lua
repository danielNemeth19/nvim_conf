local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)
--[[ local packages = {
    'nvim-treesitter/playground',
    'echasnovski/mini.nvim',
    'lewis6991/gitsigns.nvim',
    'rebelot/kanagawa.nvim',
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive', 'folke/neodev.nvim',
    'j-hui/fidget.nvim',
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    'williamboman/mason.nvim',
    { 'williamboman/mason-lspconfig.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end,
    },
    'someone-stole-my-name/yaml-companion.nvim',
    { 'danielNemeth19/bulk-comment.nvim', dev = true }
} --]]

-- require('lazy').setup(packages, {
    -- dev = {
        -- path = '~/Workspace'
    -- }
-- })

require('lazy').setup({
        { import = "daniel.plugins"},
        { import = "daniel.plugins.lsp"}
    },
    {
    dev = {
        path = '~/Workspace'
    }
})
