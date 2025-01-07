local M = {
  "nvimtools/none-ls.nvim",
}

function M.config()
  local null_ls = require("null-ls")

  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
    },
  })

  vim.keymap.set("n", "<LocalLeader>v", function()
    -- Python formatters are slow
    vim.lsp.buf.format({ timeout_ms = 3000 })
  end, {})
end

return M
