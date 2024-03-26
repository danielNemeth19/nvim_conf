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

		-- might want to use Telescope's references here...
		vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
		vim.keymap.set('n', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
		-- These are default anyway but added for clarity
		vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set('n', '<F3>', function() vim.lsp.buf.format() end, opts)

		vim.keymap.set('n', 'ga', function() vim.lsp.buf.code_action() end, opts)
	end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
	require('lspconfig')[server].setup({
		capabilities = lsp_capabilities
	})
end


require("neodev").setup({
	-- neovim setup for for init.lua and plugin development with signature_help and docs and completion for the neovim lua API
	-- setup needs to be called before the lua lsp setup
})

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {},
	handlers = {
		default_setup,
		lua_ls = function()
			require('lspconfig').lua_ls.setup({
				capabilities = lsp_capabilities,
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT'
						},
						diagnostics = {
							globals = { 'vim', 'describe', 'before_each', 'after_each', 'it' }
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME
							}
						}
					}
				}
			})
		end,
		pylsp = function()
			require("lspconfig").pylsp.setup({
				capabilities = lsp_capabilities,
				settings = {
					pylsp = {
						plugins = {
							flake8 = { enabled = false },
							pycodestyle = { enabled = true, maxLineLength = 120 },
							pyflakes = { enabled = false },
							pylint = { enabled = true, args = { "--max-line-length=120", "--disable=C0114,C0115,C0116" } },
							mccabe = { enabled = false },
						}
					}
				}
			})
		end
	}
})


local cmp = require('cmp')
cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
	},
	mapping = cmp.mapping.preset.insert({
		-- Enter key confirms completion item
		['<CR>'] = cmp.mapping.confirm({ select = false }),

		-- Ctrl + space triggers completion menu
		['<C-Space>'] = cmp.mapping.complete(),
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})
