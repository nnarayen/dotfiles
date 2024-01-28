local M = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  require("trouble").setup({
    severity = { min = vim.diagnostic.severity.WARN },
  })

  vim.keymap.set("n", "<LocalLeader>T", function()
    require("trouble").toggle()
  end)
end

return M
