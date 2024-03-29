local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
	'tsserver',
	'gopls',
	'pylsp',
	'lua_ls'
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-space>'] = cmp.mapping.complete(),
})

lsp.set_preferences({
	sign_icons = {}
})


lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})


lsp.configure('pylsp', {
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

require("neodev").setup({
	-- neovim setup for for init.lua and plugin development with signature_help and docs and completion for the neovim lua API
	-- setup needs to be called before the lua lsp setup:w
})

lsp.configure('lua_ls', {
	filetypes = { 'lua' },
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim', 'describe', 'it', 'P', 'before_each' }
			},
			runtime = {
				version = "LuaJIT",
			}
		}
	}
})


lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set('n', "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set('n', "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

	vim.keymap.set('n', "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set('n', "<leader>vd", function() vim.diagnostic.open_float() end, opts)

	vim.keymap.set('n', "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set('n', "]d", function() vim.diagnostic.goto_prev() end, opts)

	vim.keymap.set('n', "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set('n', "<leader>vrr", function() vim.lsp.buf.references() end, opts)

	-- These are default anyway but added for clarity
	vim.keymap.set('n', "<F2>", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set('n', "<F3>", function() vim.lsp.buf.format() end, opts)
end)


lsp.setup()
