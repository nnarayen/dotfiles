local M = {
  "catgoose/nvim-colorizer.lua",
  enabled = true,
}

function M.config()
  require("colorizer").setup({})
end

return M
