local M = {
  "okuuva/auto-save.nvim",
  version = '*',
  enabled = true,
}

function M.config()
  require("auto-save").setup({})
end

return M
