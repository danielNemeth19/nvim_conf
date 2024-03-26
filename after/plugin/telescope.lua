local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>o', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>r', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
vim.keymap.set('n', '<leader>bf', function()
	builtin.current_buffer_fuzzy_find({ sorting_strategy = 'ascending' });
end)
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep >  ") });
end)

require('telescope').load_extension('fzf')
