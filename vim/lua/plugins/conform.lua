local M = {
  "stevearc/conform.nvim",
}

function M.config()
  local conform = require("conform")
  require("conform").setup({
    formatters_by_ft = {
      -- Conform will run multiple formatters sequentially
      python = { "ruff_fix", "ruff_format" },
      lua = { lsp_format = "fallback" },
      typescript = { lsp_format = "fallback" },
      go = { lsp_format = "fallback" },
      json = { "jq" },
    },
  })

  vim.keymap.set("n", "<LocalLeader>v", function()
    conform.format({ async = true })
  end, {})
end

return M
