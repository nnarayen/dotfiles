local M = {
  "lewis6991/gitsigns.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  enabled = true,
}

function M.config()
  require("gitsigns").setup({
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      vim.keymap.set("n", "<LocalLeader>hn", gs.next_hunk, { buffer = bufnr })
      vim.keymap.set("n", "<LocalLeader>hp", gs.prev_hunk, { buffer = bufnr })
      vim.keymap.set({ "n", "v" }, "<LocalLeader>hu", ":Gitsigns reset_hunk<CR>", { buffer = bufnr })
    end,
  })
end

return M
