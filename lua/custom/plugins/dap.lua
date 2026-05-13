return {
  { -- Core DAP
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

      -- Helper: find a free TCP port
      local function find_open_port()
        local sock = vim.loop.new_tcp()
        sock:bind('127.0.0.1', 0)
        local port = sock:getsockname().port
        sock:close()
        return port
      end

      -- C/C++/Rust: codelldb
      dap.adapters.codelldb = {
        type = 'server',
        port = find_open_port(),
        executable = {
          command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
          args = { '--port', '${port}' },
        },
      }
      for _, lang in ipairs { 'c', 'cpp', 'rust' } do
        dap.configurations[lang] = {
          {
            name = 'Launch',
            type = 'codelldb',
            request = 'launch',
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
          },
        }
      end

      -- Lua: attach to running Neovim (requires one-small-step-for-vimkind)
      dap.configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = 'Attach to Neovim instance',
        },
      }

      -- DAP UI layout
      dapui.setup {
        layouts = {
          {
            elements = {
              { id = 'scopes',      size = 0.50 },
              { id = 'breakpoints', size = 0.25 },
              { id = 'stacks',      size = 0.25 },
            },
            position = 'right',
            size = 45,
          },
          {
            elements = {
              { id = 'repl',     size = 0.50 },
              { id = 'console',  size = 0.50 },
            },
            position = 'bottom',
            size = 12,
          },
        },
      }

      -- Keymaps
      local map = vim.keymap.set

      map('n', '<leader>dB', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
      map('n', '<leader>dC', function()
        dap.set_breakpoint(vim.fn.input 'Condition: ')
      end, { desc = 'Conditional Breakpoint' })
      map('n', '<leader>dc', dap.continue, { desc = 'Continue' })
      map('n', '<leader>do', dap.step_over, { desc = 'Step Over' })
      map('n', '<leader>di', dap.step_into, { desc = 'Step Into' })
      map('n', '<leader>dO', dap.step_out, { desc = 'Step Out' })
      map('n', '<leader>dr', dap.repl.toggle, { desc = 'Toggle REPL' })
      map('n', '<leader>du', dapui.toggle, { desc = 'Toggle DAP UI' })
      map('n', '<leader>dt', function() dapui.float_element 'terminal' end, { desc = 'DAP Terminal' })
      map('n', '<leader>dl', dap.run_last, { desc = 'Run Last' })
      map('n', '<leader>dh', dapui.eval, { desc = 'Eval under cursor' })
      map('v', '<leader>dh', function()
        dapui.eval(require('dap.utils').get_selection())
      end, { desc = 'Eval selected' })
    end,
  },

  { -- Go DAP
    'leoluz/nvim-dap-go',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = 'go',
    opts = {
      delve = { path = 'dlv' },
    },
  },

  { -- JS/TS DAP
    'mxsdev/nvim-dap-vscode-js',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue' },
    config = function()
      local js_adapter = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter'
      require('dap-vscode-js').setup {
        node_path = 'node',
        debugger_path = js_adapter,
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      }

      local dap = require 'dap'
      for _, lang in ipairs { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' } do
        dap.configurations[lang] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Debug Jest',
            program = '${workspaceFolder}/node_modules/.bin/jest',
            args = { '--runInBand' },
            cwd = '${workspaceFolder}',
            console = 'integratedTerminal',
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Debug Vitest',
            program = '${workspaceFolder}/node_modules/.bin/vitest',
            args = { '--run' },
            cwd = '${workspaceFolder}',
            console = 'integratedTerminal',
          },
        }
      end
    end,
  },

  { -- Lua DAP (attach to running Neovim)
    'jbyuki/one-small-step-for-vimkind',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = 'lua',
    config = function()
      local dap = require 'dap'
      if not dap.configurations.lua then
        dap.configurations.lua = {}
      end
      table.insert(dap.configurations.lua, {
        type = 'nlua',
        request = 'attach',
        name = 'Attach to Neovim instance',
      })
    end,
  },
}
