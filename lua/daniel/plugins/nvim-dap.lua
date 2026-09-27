return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      -- python adapter
      "mfussenegger/nvim-dap-python",
      -- go adapter
      "leoluz/nvim-dap-go",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Common setup
      require("dapui").setup({})
      require("nvim-dap-virtual-text").setup({
        commented = true, -- Show virtual text alongside comment
      })

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- Common keymaps
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, opts)
      vim.keymap.set("n", "<leader>dc", function() dap.continue() end, opts)
      vim.keymap.set("n", "<leader>do", function() dap.step_over() end, opts)
      vim.keymap.set("n", "<leader>di", function() dap.step_into() end, opts)
      vim.keymap.set("n", "<leader>dO", function() dap.step_out() end, opts)
      vim.keymap.set("n", "<leader>dq", function() require("dap").terminate() end, opts)
      vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, opts)

      -- Common visuals
      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = "", -- or "❌"
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "", -- or "→"
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      })

      --- Language specific setup
      --- Python
      local dap_python = require("dap-python")
      local home_directory = os.getenv("HOME")
      dap_python.setup(home_directory .. "/virtualenvs/debug/bin/python")

      -- Go
      require("dap-go").setup()
      
      -- JS, TS
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "::1",
        port = "${port}",
        executable = {
          command = "node",
          args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
        },
      }
      -- Configure launch settings for TypeScript
      dap.configurations.typescript = {
        -- attaching for simple scripts
        {
          name = "Launch current file (tsx)",
          type = "pwa-node",
          request = "launch",
          runtimeExecutable = "npx",
          runtimeArgs = { "tsx", "${file}" },
          cwd = "${workspaceFolder}",
          sourceMaps = true, -- Essential for mapping TS back to JS
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**" },
        },
          -- New: Attach to a running process (for production/compiled apps)
        {
          name = "Attach to Node API",
          type = "pwa-node",
          request = "attach",
          -- The port must match what you pass to `node --inspect` or `--inspect-brk`
          port = 9229, 
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          skipFiles = { "<node_internals>/**" },
        },
      }
    end,
  },
}
