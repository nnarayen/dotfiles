local M = {
  "MeanderingProgrammer/render-markdown.nvim",
}

function M.config()
  require("render-markdown").setup({
    file_types = { "markdown", "codecompanion" },
  })
end

return M
