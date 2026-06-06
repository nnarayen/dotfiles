local M = {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = true,
}

function M.config()
  require("render-markdown").setup({
    file_types = { "markdown", "codecompanion" },
    heading = {
      enabled = true,
      icons = { "󰼏  ", "󰎨  ", "󰼑  ", "󰎲  ", "󰼓  ", "󰎴  " },
      left_pad = 1,
      right_pad = 1,
    },
    anti_conceal = {
      enabled = false
    },
  })
end

return M
