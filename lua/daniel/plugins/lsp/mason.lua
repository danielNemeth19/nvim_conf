return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim"
        },
        config = true
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local default_setup = function(server)
                require('lspconfig')[server].setup({
                    capabilities = lsp_capabilities
                })
            end
            local mason_lsp = require('mason-lspconfig')
            mason_lsp.setup({
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
        end
    }
}
