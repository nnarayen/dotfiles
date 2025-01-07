return {
  "smoka7/hop.nvim",
  config = function()
    require("hop").setup({ })

    -- Set colors that differentiate from background
    vim.api.nvim_set_hl(0, 'HopNextKey', { fg = '#ff007c', bold = true })
    vim.api.nvim_set_hl(0, 'HopNextKey1', { fg = '#ffb400', bold = true })
    vim.api.nvim_set_hl(0, 'HopNextKey2', { fg = '#b98300', bold = true })
  end,
  keys = {
    { "<LocalLeader>w", ":HopWord<CR>", desc = "Highlight forward" },
    { "<LocalLeader>b", ":HopWord<CR>", desc = "Highlight backwards" },
  },
}
