return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
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
        require('telescope').load_extension('fzf')
        require('telescope').load_extension('ui-select')
        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true, silent = true, desc = "Telescope: finding files" })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { noremap = true, silent = true, desc = "Telescope: fuzzy finding git files" })
        vim.keymap.set('n', '<leader>o', builtin.lsp_document_symbols, { noremap = true, silent = true, desc = "Telescope: LSP document symbols" })
        vim.keymap.set('n', '<leader>r', builtin.lsp_references, { noremap = true, silent = true, desc = "Telescope: LSP references" })
        vim.keymap.set('n', '<leader>dl', builtin.diagnostics, { noremap = true, silent = true, desc = "Telescope: diagnostics" })
        vim.keymap.set('n', '<leader>i', builtin.lsp_implementations, { noremap = true, silent = true, desc = "Telescope: LSP implementations" })
        vim.keymap.set('n', '<leader>h', builtin.help_tags, { noremap = true, silent = true, desc = "Telescope: help tags" })
        vim.keymap.set('n', '<leader>b', builtin.buffers, { noremap = true, silent = true, desc = "Telescope: buffers" })
        vim.keymap.set('n', '<leader>ch', builtin.command_history, { noremap = true, silent = true, desc = "Telescope: command history" })
        vim.keymap.set('n', '<leader>km', builtin.keymaps, { noremap = true, silent = true, desc = "Telescope: keymaps" })
        vim.keymap.set('n', '<leader>bf', function()
            builtin.current_buffer_fuzzy_find({ sorting_strategy = 'ascending' });
        end,  { noremap = true, silent = true, desc = "Telescope: searching current buffer" } )
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep >  ") });
        end, { noremap = true, silent = true, desc = "Telescope: grep project" })
    end
}
