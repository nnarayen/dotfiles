local M = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  require("trouble").setup({
    modes = {
      diagnostics_buffer = {
        mode = "diagnostics",
        filter = {
          buf = 0,
          severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN }
        },
      },
    }
  })

  vim.keymap.set("n", "<LocalLeader>T", function()
    require("trouble").toggle('diagnostics_buffer')
  end)
end

return M
