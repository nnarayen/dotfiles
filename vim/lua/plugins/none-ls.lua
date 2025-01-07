local M = {
  "nvimtools/none-ls.nvim",
}

function M.config()
  local null_ls = require("null-ls")

  null_ls.setup({
    sources = {
      -- null_ls.builtins.formatting.black,
    },
  })

  vim.keymap.set("n", "<LocalLeader>v", function()
    vim.lsp.buf.format()
  end, {})
end

return M
