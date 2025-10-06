local M = {
  "gbprod/yanky.nvim",
  enabled = true,
}

function M.config()
  require("yanky").setup({
    highlight = {
      on_put = false,
      timer = 200,
    },
  })

  -- Key mappings
  vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
  vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
  vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
  vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
end

return M
