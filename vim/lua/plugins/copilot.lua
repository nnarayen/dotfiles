local M = {
  "github/copilot.vim",
}

function M.init()
  vim.g.copilot_no_tab_map = true
end

function M.config()
  vim.api.nvim_set_keymap('i', '<C-l>', 'copilot#Accept("")', { expr=true, silent=true })
end

return M
