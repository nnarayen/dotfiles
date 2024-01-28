local M = {
  "nvimtools/none-ls.nvim",
}

function M.config()
  local null_ls = require("null-ls")

  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
    },
  })

  -- Keybinding to format, but disable tsserver
  vim.keymap.set("n", "<LocalLeader>v", function()
    vim.lsp.buf.format({
      filter = function(client)
        return client.name ~= "tsserver"
      end,
    })
  end, {})
end

return M
