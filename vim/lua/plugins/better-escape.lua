local M = {
  "max397574/better-escape.nvim",
  enabled = true,
}

function M.config()
  require("better_escape").setup({ })
end

return M
