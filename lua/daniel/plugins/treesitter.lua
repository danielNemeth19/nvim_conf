local log_level = vim.log.levels.DEBUG
local branch = 'main'

local function notify(msg, level)
  if level >= log_level then
    vim.notify(msg, level)
  end
end

local function register(ensure_installed)
  for filetype, parser in pairs(ensure_installed) do
    local filetypes = vim.treesitter.language.get_filetypes(parser)
    if not vim.tbl_contains(filetypes, filetype) then
      table.insert(filetypes, filetype)
    end

    vim.treesitter.language.register(parser, filetypes)
  end
end

local function install_and_start()
  vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    callback = function(event)
      local bufnr = event.buf
      local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })

      if filetype == '' then
        return
      end

      local parser_name = vim.treesitter.language.get_lang(filetype)
      notify('parser name is ' .. parser_name, vim.log.levels.DEBUG)
      if not parser_name then
        notify('Filetype' .. vim.inspect(filetype) .. ' has no parser registered', vim.log.levels.DEBUG)
        return
      end

      local parser_configs = require 'nvim-treesitter.parsers'
      -- notify('parser configs: ' .. vim.inspect(parser_configs), vim.log.levels.DEBUG)
      local parser_config = nil
      if branch == 'master' then
        parser_config = parser_configs.list[parser_name]
      elseif branch == 'main' then
        parser_config = parser_configs[parser_name]
        notify('parser can be used' .. vim.inspect(parser_config), vim.log.levels.DEBUG)
      end
      if not parser_config then
        return
      end

      local parser_installed, parser_object = pcall(vim.treesitter.get_parser, bufnr, parser_name)

      vim.inspect(parser_object)
      if not parser_installed or not parser_object then
        if branch == 'master' then
          vim.cmd('TSInstallSync ' .. parser_name)
        elseif branch == 'main' then
          local ok, result = require('nvim-treesitter').install({ parser_name }):wait(30000)
          if not ok then
            notify("install error: " .. vim.inspect(result), vim.log.levels.ERROR )
          else
            notify("Install result: " .. vim.inspect(result), vim.log.levels.INFO)
          end
        end
      end

      parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)
      parser_installed, parser_object = pcall(vim.treesitter.get_parser, bufnr, parser_name)
      -- notify('parser installed 2: ' .. vim.inspect(parser_installed), vim.log.levels.DEBUG)
      -- if not parser_installed then
        -- notify('Failed to get parser for ' .. parser_name .. ' after installation', vim.log.levels.WARN)
        -- return
      -- end
      vim.treesitter.start(bufnr, parser_name)
    end,
  })
end

return {
  ---@module 'lazy'
  ---@type LazySpec
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    event = 'BufRead',
    branch = 'main',
    build = ':TSUpdate',

    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    ---@module 'nvim-treesitter'
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      -- Other plugins can pass in desired filetype / parser combos
      ensure_installed = {},
    },

    config = function(_, opts)
      register(opts.ensure_installed)
      install_and_start()
    end,
  }
}
