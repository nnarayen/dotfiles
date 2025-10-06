local M = {
  "neovim/nvim-lspconfig",
  enabled = true,
}

function M.config()
  require("plugins.lsp.lsp")
end

return M
