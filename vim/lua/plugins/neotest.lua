local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-python",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  enabled = true,
}

function M.config()
  neotest = require("neotest")
  neotest.setup({
    adapters = {
      require("neotest-python")
    }
  })

  vim.keymap.set("n", "<LocalLeader>dt", function() neotest.run.run() end, {})
  vim.keymap.set("n", "<LocalLeader>dT", function() neotest.run.run({ strategy = "dap" }) end, {})
  vim.keymap.set("n", "<LocalLeader>dS", function() neotest.run.stop() end, {})
end

return M
