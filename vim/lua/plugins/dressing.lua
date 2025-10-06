local M = {
  "stevearc/dressing.nvim",
  enabled = true,
}

function M.config()
  require("dressing").setup({})
end

return M
