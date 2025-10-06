local M = {
  "gbprod/cutlass.nvim",
  enabled = true,
}

function M.config()
  require("cutlass").setup({
    cut_key = 'd',
  })

  -- Blackhole D operation
  vim.api.nvim_set_keymap('n', 'D', '"_D', { noremap = true, silent = true })
end

return M
