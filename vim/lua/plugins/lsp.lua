local M = {
  "neovim/nvim-lspconfig",
}

function M.config()
  require("plugins.lsp.lsp")
end

return M
