-- treesitter configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "bash",
    "go",
    "json",
    "hcl",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}
