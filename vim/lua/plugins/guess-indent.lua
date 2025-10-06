local M = {
  "NMAC427/guess-indent.nvim",
  enabled = true,
}

function M.config()
  require("guess-indent").setup({})
end

return M
