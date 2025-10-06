local M = {
  "sindrets/diffview.nvim",
  enabled = true,
}

function M.config()
  vim.keymap.set("n", "<LocalLeader>H", ":DiffviewFileHistory %<CR>")
end

return M
