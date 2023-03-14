return {
  'numToStr/Navigator.nvim',
  config = function()
    require('Navigator').setup()
  end,
  keys = {
    { "<C-h>", "<CMD>NavigatorLeft<CR>", desc = "Move window left", mode = "n" },
    { "<C-j>", "<CMD>NavigatorUp<CR>", desc = "Move window up", mode = "n" },
    { "<C-k>", "<CMD>NavigatorDown<CR>", desc = "Move window down", mode = "n" },
    { "<C-l>", "<CMD>NavigatorRight<CR>", desc = "Move window right", mode = "n" },
  }
}
