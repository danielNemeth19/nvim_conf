return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',

            build = 'make',

            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        {
            'nvim-tree/nvim-web-devicons',
            enabled = vim.g.have_nerd_font
        }
    },
    config = function()
        local telescope = require('telescope')
        telescope.setup {
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                }
            }
        }
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>o', builtin.lsp_document_symbols, {})
        vim.keymap.set('n', '<leader>r', builtin.lsp_references, {})
        vim.keymap.set('n', '<leader>dl', builtin.diagnostics, {})
        vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>bf', function()
            builtin.current_buffer_fuzzy_find({ sorting_strategy = 'ascending' });
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep >  ") });
        end)
    end
}
