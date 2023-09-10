return {
  'numToStr/Navigator.nvim',
  config = function()
    require('Navigator').setup()
  end,
  keys = {
    { "<C-h>", ":NavigatorLeft<CR>", desc = "Move window left", mode = "n" },
    { "<C-j>", ":NavigatorDown<CR>", desc = "Move window up", mode = "n" },
    { "<C-k>", ":NavigatorUp<CR>", desc = "Move window down", mode = "n" },
    { "<C-l>", ":NavigatorRight<CR>", desc = "Move window right", mode = "n" },
  }
}
