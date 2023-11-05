local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-14',
  name = 'lldb'
}

local dap = require('dap')
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
  {
    -- If you get an "Operation not permitted" error using this, try disabling YAMA:
    --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    name = "Attach to process",
    type = 'cpp',  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
    request = 'attach',
    pid = require('dap.utils').pick_process,
    args = {},
    runInTerminal = false,
  },
}

dap.configurations.c = dap.configurations.cpp

require("dapui").setup()

-- Keymaps
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<leader>du', function() require("dapui").toggle() end)
