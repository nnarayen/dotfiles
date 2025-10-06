local M = {
  "linux-cultist/venv-selector.nvim",
  ft = "python",
  dependencies = {
    "nvim-telescope/telescope.nvim"
  },
  enabled = true,
}

function M.config()
  require('venv-selector').setup({ })
end

return M
