local M = {
  "mfussenegger/nvim-dap-python",
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
  },
}

function M.config()
  require("dap-python").setup("python")
  require("dapui").setup({
    layouts = { {
      elements = { {
        id = "repl",
        size = 0.75
      }, },
      position = "bottom",
      size = 15
    } },
  })

  local dap, dapui = require("dap"), require("dapui")
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  vim.keymap.set("n", "<LocalLeader>db", function() dap.toggle_breakpoint() end, {})
  vim.keymap.set("n", "<LocalLeader>dc", function() dap.continue() end, {})

  -- Customize signs
  vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
end

return M
