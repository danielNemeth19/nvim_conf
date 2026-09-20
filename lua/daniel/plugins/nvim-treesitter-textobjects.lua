return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  init = function()
    vim.g.no_plugin_maps = true
  end,
  config = function()
    require("nvim-treesitter-textobjects").setup {
      move = { set_jumps = true },
      select = { lookahead = true },
    }
    -- Selecting text objects
    -- all these work in visual mode ("x")
    -- and in operator-pending mode ("o"):
    -- these are:
      -- 'd' -> delete
      -- 'c' -> change (delete + insert mode)
      -- 'y' -> copy
      -- '>' -> indent
      -- '=' -> re-indent
    -- methods and functions
    local select = require("nvim-treesitter-textobjects.select")
    vim.keymap.set({ "x", "o" }, "am", function()
      select.select_textobject("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "im", function()
      select.select_textobject("@function.inner", "textobjects")
    end)
    -- classes
    vim.keymap.set({ "x", "o" }, "ac", function()
      select.select_textobject("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ic", function()
      select.select_textobject("@class.inner", "textobjects")
    end)
    -- for local scope
    vim.keymap.set({ "x", "o" }, "as", function()
      select.select_textobject("@local.scope", "locals")
    end)

    -- Swapping text objects
    local swap = require("nvim-treesitter-textobjects.swap")
    vim.keymap.set("n", "<leader>a", function()
      swap.swap_next("@parameter.inner")
    end)
    vim.keymap.set("n", "<leader>A", function()
      swap.swap_previous("@parameter.outer")
    end)

    -- Moving between text objects 
    local move = require("nvim-treesitter-textobjects.move")
    -- methods and functions
    vim.keymap.set({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end)
    vim.keymap.set({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end)
    vim.keymap.set({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end)
    vim.keymap.set({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end)
    -- classes
    vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end)
    vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end)

    -- Loops
    vim.keymap.set({ "n", "x", "o" }, "]o", function() move.goto_next_start("@loop.outer", "textobjects") end)
    vim.keymap.set({ "n", "x", "o" }, "[o", function() move.goto_previous_start("@loop.outer", "textobjects") end)

    -- Conditionals
    vim.keymap.set({ "n", "x", "o" }, "]d", function() move.goto_next("@conditional.outer", "textobjects") end)
    vim.keymap.set({ "n", "x", "o" }, "[d", function() move.goto_previous("@conditional.outer", "textobjects") end)

    -- Repeating movements
    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
  end
}
