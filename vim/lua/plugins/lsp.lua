local M = {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false
    }
  },
  enabled = true,
}

function M.config()
  require("plugins.lsp.lsp")
end

return M
