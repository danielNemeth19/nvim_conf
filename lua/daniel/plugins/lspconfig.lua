return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { "j-hui/fidget.nvim",    opts = {} },
    { "saghen/blink.cmp" },
    {
      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
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

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end
    })
    --continue here
    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.

    local capabilities = require('blink.cmp').get_lsp_capabilities()
    --This function can dynamicaly set the pylint executable to correct path
    --if a python virtualenv is activated (hence on path)
    local function set_pylint_path()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        local pylint_path = venv .. "/bin/pylint"
        if vim.fn.executable(pylint_path) == 1 then
          local to_exec = venv .. "/bin/pylint"
          return venv .. "/bin/pylint"
        end
        -- If we're in a python virtual env but pylint is not installed set path to 'nil'
        -- to fallback to pylsp's pylint (~/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/pylint)
        return nil
      end
      return nil
    end

    -- Enable the following language servers
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      cssls = {
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
              }
            }
          }
        }
      },
      gopls = {},
      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = {
              disable = { 'missing-fields' },
              globals = { 'vim', 'describe', 'before_each', 'after_each', 'it', 'P' }
            },
            completion = {
              callSnippet = 'Replace',
            },
            type = {
              -- Enforce type annotation usage and strict checking
              enforceAnnotation = true,
              strict = true,
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME
              }
            }
          }
        }
      },
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              flake8 = { enabled = false },
              pycodestyle = { enabled = true, maxLineLength = 120 },
              pyflakes = { enabled = false },
              pylint = {
                enabled = true,
                executable = set_pylint_path()
              },
              mccabe = { enabled = false },
            }
          }
        },
      }
    }
    require('mason').setup()
    --define other tools that we want Mason to install
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })
    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    require('mason-lspconfig').setup({
      ensure_installed = {}
    })

    vim.lsp.config('*', {
      capabilities = capabilities
    })

    for server, config in pairs(servers) do
      vim.lsp.config(server, config)
    end
  end
}
