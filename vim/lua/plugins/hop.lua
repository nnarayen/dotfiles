return {
  "phaazon/hop.nvim",
  config = function()
    require("hop").setup({})
  end,
  keys = {
    { "<LocalLeader>w", ":HopWord<CR>", desc = "Highlight forward" },
    { "<LocalLeader>b", ":HopWord<CR>", desc = "Highlight backwards" },
  },
}
