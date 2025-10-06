return {
  "tpope/vim-fugitive",
  keys = {
    { "<LocalLeader>gs", "<cmd>Git<CR>gg<C-n>", desc = "Git status", remap = true },
    { "<LocalLeader>gd", "<cmd>Git diff<CR>", desc = "Git diff" },
    { "<LocalLeader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
  },
  config = function()
    vim.g.fugitive_github_domains = { "github.com" }
  end,
  dependencies = {
    "tpope/vim-rhubarb",
  },
  enabled = true,
}
