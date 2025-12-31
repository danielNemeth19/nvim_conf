-- return {
  -- {
    -- 'nvim-treesitter/nvim-treesitter',
    -- build = ':TSUpdate',
    -- opts = {
      -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "go", "fish", "typescript" },
      -- auto_install = true,
      -- sync_install = false,
      -- highlight = {
        -- enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        --disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        -- additional_vim_regex_highlighting = false,
      -- },
      -- indent = { enable = true },
    -- },
    -- config = function(_, opts)
      -- require("nvim-treesitter.install").prefer_git = true
      -- require("nvim-treesitter.configs").setup(opts)
    -- end
  -- },
  -- { "nvim-treesitter/playground" }
-- }

return {
  ---@module 'lazy'
  ---@type LazySpec
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    dependencies = {
      { 'folke/ts-comments.nvim', opts = {} },
    },

    branch = 'main',
    build = function()
      -- update parsers, if TSUpdate exists
      if vim.fn.exists(':TSUpdate') == 2 then vim.cmd('TSUpdate') end
    end,

    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    ---@module 'nvim-treesitter'
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {},

    config = function(_, opts)
      local ensure_installed = {
        'c',
        'python',
        'go',
        'lua',
        'typescript',
        'javascript',
        'html',
        'css',
        'fish',
        'bash',
        'vim',
        'vimdoc',
        'query',
        'diff',
        'gitcommit',
        'luadoc',
        'markdown',
        'markdown_inline',
      }
      -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "go", "fish", "typescript" },

      -- make sure nvim-treesitter can load
      local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')

      -- no nvim-treesitter, maybe fresh install
      if not ok then return end

      nvim_treesitter.install(ensure_installed)
    end,
  },
  -- { "nvim-treesitter/playground" }
}
