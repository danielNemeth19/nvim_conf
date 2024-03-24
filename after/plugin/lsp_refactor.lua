vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP Actions',
	callback = function(event)
		local opts = { buffer = event.buf }

		-- these will be buffer-local keybindings
		-- they will only be registered if there's an active language server
		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
		-- note: most servers won't implement declaration (only definition)
		vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
		vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
		vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
		vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
		vim.keymap.set('n', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
		-- These are default anyway but added for clarity
		vim.keymap.set('n', '<F3>', function() vim.lsp.buf.format() end, opts)
		vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts)
		
		vim.keymap.set('n', 'ga', function() vim.lsp.buf.code_action() end, opts)
	end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
	require('lspconfig')[server].setup({
		capabilities = lsp_capabilities
	})
end

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {},
	handlers = {
		default_setup
	},
})
