local M = {
  "numToStr/Comment.nvim",
  enabled = true,
}

function M.config()
  require("Comment").setup({
    mappings = {
      basic = false,
      extra = false,
    },
  })
end

function normal_toggle()
  require("Comment.api").toggle.linewise.current()
end

function visual_toggle()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end

M.keys = {
  { "<LocalLeader>c", normal_toggle, desc = "Toggle comment" },
  { "<LocalLeader>c", visual_toggle, desc = "Toggle comment", mode = "v" },
}

return M
