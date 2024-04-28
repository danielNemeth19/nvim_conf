return {
    {
        "folke/neodev.nvim",
        event = {"BufReadPre", "BufNewFile"},
        config = true
    },
    {
        "neovim/nvim-lspconfig",
        event = {"BufReadPre", "BufNewFile"},
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            "folke/neodev.nvim",
            {"j-hui/fidget.nvim", opts = {}},
        }
    }
}
--[[ copy everything here
vim.diagnostic.config({
    float = {
        border = 'rounded'
    },
    underline = false,
    virtual_text = {
        source = "if_many",
        spacing = 2,
        prefix = "●"
    }
})

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP Actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        -- these will be buffer-local keybindings
        -- they will only be registered if there's an active language server
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- note: most servers won't implement declaration
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) -- Telescope references: <leader>r

        vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)
        -- These are default anyway but added for clarity
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<F3>', vim.lsp.buf.format, opts)
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
                            globals = { 'vim', 'describe', 'before_each', 'after_each', 'it', 'P' }
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
        ['<Tab>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl + space triggers completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
}) --]]
