local M = {
  "svermeulen/vim-easyclip",
}

function M.config()
  vim.keymap.set("x", "d", "<Plug>MoveMotionXPlug")
  vim.keymap.set("x", "x", "<Plug>MoveMotionXPlug")
  vim.keymap.set("n", "dd", "<Plug>MoveMotionLinePlug")
end

return M
