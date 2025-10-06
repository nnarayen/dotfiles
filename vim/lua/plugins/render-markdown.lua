local M = {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = true,
}

function M.config()
  require("render-markdown").setup({
    file_types = { "markdown", "codecompanion" },
  })
end

return M
