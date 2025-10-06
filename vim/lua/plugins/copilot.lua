local M = {
  "zbirenbaum/copilot.lua",
  enabled = true,
}

function M.config()
  local copilot = require("copilot")
  local suggestions = require('copilot.suggestion')

  copilot.setup({
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
    },
  })

  -- Explicitly bind C-l, due to interactions with blink
  vim.keymap.set('i', '<C-l>', function()
    if suggestions.is_visible() then
      suggestions.accept()
    else
      return '<C-l>'
    end
  end, { expr = true, silent = true, desc = "Accept Copilot suggestion" })
end

return M
