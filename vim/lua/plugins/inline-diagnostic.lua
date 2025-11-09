local M = {
  "rachartier/tiny-inline-diagnostic.nvim",
  priority = 1000,
  enabled = true,
}

function M.config()
  require("tiny-inline-diagnostic").setup({
    preset = "powerline",
    options = {
      multilines = {
        enabled = true,
        always_show = true,
        trim_whitespaces = true,
      },
      severity = {
        vim.diagnostic.severity.ERROR,
      },
    },
  })

  vim.diagnostic.config({ virtual_text = false })
end

return M
