local M = {
  "stevearc/conform.nvim",
}

function M.config()
  local conform = require("conform")
  require("conform").setup({
    formatters_by_ft = {
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
    },
  })

  vim.keymap.set("n", "<LocalLeader>v", function()
    conform.format({ async = true })
  end, {})
end

return M
