local M = {
  "ray-x/go.nvim",
}

function M.config()
  require("go").setup({ })

  vim.keymap.set('n', '<LocalLeader>Fs', ':GoFillStruct<CR>', {buffer = bufnr})
  vim.keymap.set('n', '<LocalLeader>Fw', ':GoFillSwitch<CR>', {buffer = bufnr})
end

-- Update all binaries
M.build = ':lua require("go.install").update_all_sync()'

return M
