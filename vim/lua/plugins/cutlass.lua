local M = {
  "gbprod/cutlass.nvim",
}

function M.config()
  require("cutlass").setup({
    cut_key = 'd',
    exclude = {
      { 'nd', 'nD' }
    }
  })
end

return M
