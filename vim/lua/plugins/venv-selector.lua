local M = {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  dependencies = {
    "nvim-telescope/telescope.nvim"
  }
}

function M.config()
  require('venv-selector').setup({
    poetry_path = "/home/vscode/.cache/pypoetry/virtualenvs"
  })
end

return M
