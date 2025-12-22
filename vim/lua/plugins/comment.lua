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

M.keys = {
  { "<LocalLeader>c", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle comment" },
  { "<LocalLeader>c", "<Plug>(comment_toggle_linewise_visual)",  desc = "Toggle comment", mode = "v" },
}

return M
