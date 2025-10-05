local M = {
  "linux-cultist/venv-selector.nvim",
  ft = "python",
  dependencies = {
    "nvim-telescope/telescope.nvim"
  }
}

function M.config()
  require('venv-selector').setup({ })
end

return M
