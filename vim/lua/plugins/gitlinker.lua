local M = {
  "linrongbin16/gitlinker.nvim",
}

function M.config()
  local gitlinker = require("gitlinker")
  gitlinker.setup({
    -- don't print permanent url in command line
    message = false,
    -- don't highlight after visual selection
    highlight_duration = 0,
  })

  vim.keymap.set({"n", 'v'}, "<LocalLeader>gr", gitlinker.link, { silent = true, noremap = true, desc = "GitLink" })
end

return M
