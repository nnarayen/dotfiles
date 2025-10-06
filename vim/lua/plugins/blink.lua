local M = {
  "saghen/blink.cmp",
  -- use a release tag to download pre-built binaries
  version = '1.*',
  enabled = true,
}

function M.config()
  require("blink.cmp").setup({
    keymap = {
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },
    cmdline = { enabled = false },
    enabled = function() return not vim.tbl_contains({ "DressingInput" }, vim.bo.filetype) end,
    sources = {
      default = { 'lsp', 'path', 'buffer' },
    },
  })
end

return M
